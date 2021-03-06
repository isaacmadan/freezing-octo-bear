<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="site.*, java.util.*,java.sql.*,java.io.*,java.text.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="styles.css">
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.1.1.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />
<link href='http://fonts.googleapis.com/css?family=Merriweather' rel='stylesheet' type='text/css'>
<script src="site.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<%
	User user = (User)session.getAttribute("user");
	if(user != null) {
		//out.println(user.getUsername()+"'s Dashboard");
		Cookie cookie = new Cookie("freezing-octo-bear",user.getUsername());
		cookie.setMaxAge(60*60*72); //72 hours
		response.addCookie(cookie);
	}
	else {
		if(request == null || response == null) {
			return;
		}
		RequestDispatcher dispatch = request.getRequestDispatcher("index.jsp");
		dispatch.forward(request, response);
	}
%>

<%!/*NOTE TO OTHERS

	 When quiz_summary_page posts to a quiz page with the parameter "quiz_id"
	 When quiz_summary_page posts to a profile page with the parameter "id"

	 */

	private Quiz quiz;
	private AccountManager manager;
	private User taker;
	private User challenger = null;
	
	private ArrayList<User> resultsToUsers(ArrayList<Result> res) {
		ArrayList<User> users = new ArrayList<User>();
		for (int i = 0; i < res.size(); i++) {
			int id = res.get(i).userId;
			users.add(i, manager.getAccountById(String.valueOf(id)));
		}
		return users;
	}

	/**Writes html for single table entry in a html table listing results*/
	private static void listResult(JspWriter out, Result result, User user) {
		double score = result.pointsScored / (double) result.maxPossiblePoints;
		DecimalFormat df = new DecimalFormat("0%");
		String score2 = df.format(score);
		String date = result.dateString();
		try {
			out.println("<tr><td> <a href='profile.jsp?id=" + result.userId
					+ "'>" + user.getUsername() + "</a>" + "</td><td>" + score2
					+ "</td><td>" + result.durationString() + "</td><td>" + date);
		} catch (IOException ignored) {
		}
	}

	/**Writes html for entire table of results and the corresponding users*/
	private static void listPerformers(JspWriter out, ArrayList<Result> res,
			ArrayList<User> users) {
		if (res == null || users == null)
			return;
		if (res.size() == 0) {
			return;
		}
		try {
			out.println("<table>");
			out.println("<tr><th>User</th><th>Percent Score</th><th>Duration of Quiz</th><th>TimeTaken</th></tr>");
			for (int i = 0; i < res.size(); i++) {
				Result result = res.get(i);
				User user = users.get(i);
				listResult(out, result, user);
			}
			out.println("</table>");
		} catch (IOException ignored) {
		}
	}%>

<%
	// SETUP
	manager = new AccountManager();
	new ReviewManager();
	//quiz = (new QuizManager()).getQuizByQuizId(7);
	//taker = manager.getAccountById("1");
	taker = (User) session.getAttribute("user");
	quiz = (new QuizManager()).getQuizByQuizId(Integer.parseInt(request
			.getParameter("quiz_id")));
	if (quiz == null) {
		out.println("Sorry this quiz is corrupted. We can't display it.");
		return;
	}
	new QuizResult();

	if (taker == null) {
		RequestDispatcher dispath = request
				.getRequestDispatcher("unauthorized.jsp");
		dispath.forward(request, response);
	}
	if (quiz == null) {
		RequestDispatcher dispath = request
				.getRequestDispatcher("unauthorized.jsp");
		dispath.forward(request, response);
	}

	/*Each quiz should have a summary page which includes
	 The text description of the quiz.
	 The creator of the quiz (hot linked to the creators user page).
	 A list of the user's past performance on this specific quiz.  Consider allowing the 
	 user to order this by date, by percent correct, and by amount of time the quiz took.
	 A list of the highest performers of all time.
	 A list of top performers in the last day.
	 1
	 A list showing the performance of recent test takers (both good and bad).
	 Summary statistics on how well all users have performed on the quiz.
	 A way to initiate taking the quiz.
	 */
%>

<title>Quizzard - <%=quiz.getTitle()%></title>

</head>
<body>

<!-- facebook like button -->
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=265049076945249";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
<!-- end -->

<div class='header-wrapper'>
<div class="header"><img src='wizard_hat.png' width='30px' /><a href='index.jsp'>QUIZZARD</a>

	<ul class='menu'>
		<li><a href = "make_quiz.jsp">Make a quiz</a></li>
		<li><% out.println("<a href='profile.jsp?id="+user.getId()+"'>My public profile</a>"); %></li>
		<li><% out.println("<a href='inbox.jsp'>My inbox</a>"); %></li>
		<li><% out.println("<a href='history.jsp'>My performance history</a>"); %></li>
		<li><a href="logout.jsp">Logout</a></li>
	</ul>
	
</div>
</div>

<div class='subheader-wrapper'>
<div class='subheader'>

<div id='subheader-username'><%= user.getUsername() %></div>

<div id='search'>
	<form action="search.jsp" method="GET">
		<input type="text" name="query" />
		<input type="submit" value="Search" />
	</form>
</div>

</div>
</div>

<div class='content-wrapper'>
<div class='content'>
	<h1>
		<%=quiz.getTitle()%>
		Summary
	</h1>

<!-- ADMIN CODE -->
	<%
	new AdminControl();
	if(AdminControl.isAdmin(user.getId())) {
		out.println("<div class='admin'>");
		out.println("<div class='pad pad-vertical'>");
		out.println("<h2>Admin Controls</h2>");
		out.println("<button id='deleteQuizResults' onclick='deleteQuizResults(" + quiz.getQuiz_id() + ")'>Clear quiz results</button>");
		out.println("<button id='deleteQuiz' onclick='deleteQuiz("+quiz.getQuiz_id()+")'>Delete quiz</button>");	
		out.println("</div>");
		out.println("</div>");
	}
	%>

	<br />
		<!-- challenger -->
		<%
			if(request.getParameter("challenger_id") != null) {
				challenger = manager.getAccountById(request.getParameter("challenger_id"));
				out.println("<div class='success'>");
				out.println("<h3>");
				
				String challengerBestScore = "";
				if(request.getParameter("challenger_best_score") != null) {
					challengerBestScore = request.getParameter("challenger_best_score");
				}
				if(challenger != null) {
					String bestScoreString = "Their best score is " + challengerBestScore + ".";
					if(challengerBestScore.equals("-1"))
						bestScoreString = "They haven't taken this quiz yet.";
					out.println(challenger.getUsername()+" has challenged you! " + bestScoreString);
				}
				out.println("</h3>");
				out.println("</div>");
			}
		%>

	<div class='col-1-4'>
	<div class='pad-left-small'>
		<p class='h3'><a name='top'>Menu</a></p>
		<p><a href='#yourPastScores'>Your past scores</a></p>
		<p><a href='#bestScoresAllTime'>Best scores of all time</a></p>
		<p><a href='#bestScoresLastDay'>Best scores in the last day</a></p>
		<p><a href='#recentScores'>Recent scores</a></p>
		<p><a href='#statistics'>Statistics</a></p>
		<p><a href='#ratingsReviews'>Ratings and review</a></p>
	</div>
	</div>
	
	<div class='col-1-4'>
	<div class='pad-left-small'>
<%
if(!quiz.isOne_page()) {
	if(!quiz.isPractice_mode()) {
		out.println("<form action=\"quiz_multi_page.jsp\" method=\"POST\">");
		session.setAttribute("listOfAnswers", new ArrayList<String>());
	}
	else {
		quiz.populateQuiz();
		out.println("<form action=\"quiz_multi_page_practice.jsp\" method=\"POST\">");
		ArrayList<Integer> indices = new ArrayList<Integer>();
		for(int k = 0; k < quiz.getQuestions().size(); k++) {
			indices.add(0);
		}
		session.setAttribute("indices", indices);
	}
	out.println("<input type=\"hidden\" name=\"question_num\" value=\"" + Integer.toString(0) +"\">");
	out.println("<input type=\"hidden\" name=\"start_time\" value=\"" + Long.toString(System.currentTimeMillis()) +"\">");
	out.println("<input type='hidden' name='score' value = '0'>");
	ArrayList<Integer> arr = randomize();
	if(!quiz.isRandom_question()) {
		arr = new ArrayList<Integer>();
		for(int i = 0; i < quiz.getQuestions().size(); i++) {
			arr.add(i);
		}
	}
	session.setAttribute("randomIndex", arr);
	session.setAttribute("arrAnswers", setup(request, response, session, out));
}
else {
	if(!quiz.isPractice_mode())
		out.println("<form action=\"quiz_taker.jsp\" method=\"POST\">");
	else {
		quiz.populateQuiz();
		out.println("<form action=\"quiz_multi_page_practice.jsp\" method=\"POST\">");
		ArrayList<Integer> indices = new ArrayList<Integer>();
		for(int k = 0; k < quiz.getQuestions().size(); k++) {
			indices.add(0);
		}
		session.setAttribute("indices", indices);
		out.println("<input type=\"hidden\" name=\"question_num\" value=\"" + Integer.toString(0) +"\">");
		ArrayList<Integer> arr = randomize();
		if(!quiz.isRandom_question()) {
			arr = new ArrayList<Integer>();
			for(int i = 0; i < quiz.getQuestions().size(); i++) {
				arr.add(i);
			}
		}
		session.setAttribute("randomIndex", arr);
		session.setAttribute("arrAnswers", setup(request, response, session, out));
	}
}
%>

<%!


private ArrayList<Answer> setup(HttpServletRequest request, HttpServletResponse response, HttpSession session, JspWriter out) {

		ArrayList<Question> questions = quiz.getQuestions();
		ArrayList<Answer> answers = new ArrayList<Answer>();
		for(int i = 0; i < questions.size(); i++){
			Question q = questions.get(i);
			Answer a = q.getAnswer();
			answers.add(a);
		}
		return answers;
	}
%>

<%!
private ArrayList<Integer> randomize() {
	quiz.populateQuiz();
	ArrayList<Integer> arr = new ArrayList<Integer>();
	for(int i = 0; i < quiz.getQuestions().size(); i++) {
		arr.add(i);
	}
	Collections.shuffle(arr);
	return arr;
}
%>
		<input type="hidden" name="quiz_id" value="<%=quiz.getQuiz_id()%>" />
		<input type='submit' value='Take this Quiz!' />
	</form>
	
	<form action="challenge.jsp" method="POST">
		<input type="hidden" name="challenger_id" value="<%=taker.getId()%>" />
		<input type="hidden" name="quiz_id" value="<%=quiz.getQuiz_id()%>" />
		<select name="friend_id">
  			<% 
  			HashSet<Integer> friends = manager.getFriends(taker.getId()); 
  			for(Integer userId : friends) {
  				out.println("<option value='"+userId+"'>"+manager.getAccountById(String.valueOf(userId)).getUsername()+"</option>");
  			}
  			%>
		</select>
		<input type="hidden" name="quiz_id" value="<%=quiz.getQuiz_id()%>" />
		<input type="submit" value="Challenge this friend" />
	</form>

	<!-- ratings/reviews -->
	<%
		new ReviewManager();
		String review = request.getParameter("review");
		String rating = request.getParameter("rating");
		boolean justTookIt = false;
		if(review != null && rating != null)
			justTookIt = true;
		
		boolean tookQuiz = ReviewManager.tookQuiz(user.getId(), quiz.getQuiz_id());
		if(!justTookIt && (tookQuiz && !ReviewManager.alreadyReviewed(taker.getId(), quiz.getQuiz_id()))) {
			out.println("<input type='submit' onclick='showReview()' value='Review/rate this quiz' />");
		}
	%>
	
	<!-- process ratings/review -->
	<%
		
		if(review != null && rating != null) {
			ReviewManager.addReview(user.getId(), quiz.getQuiz_id(), review, Integer.parseInt(rating));
			out.println("<div class='success'>Your review/rating was saved successfully.</div><br />");
		}
	%>
	
	<div id='review'>
		<form method='POST'>
			<input type='hidden' name='quiz_id' value='<%= quiz.getQuiz_id() %>' />
			<table>
				<tr><td>Review</td><td><textarea name='review' id='review'></textarea></td></tr>
				<tr><td>Rating</td>
					<td>
						<select name='rating' id='rating'>
							<option value='1'>1</option>
							<option value='2'>2</option>
							<option value='3'>3</option>
							<option value='4'>4</option>
							<option value='5'>5</option>
							<option value='6'>6</option>
							<option value='7'>7</option>
							<option value='8'>8</option>
							<option value='9'>9</option>
							<option value='10'>10</option>
						</select>
					</td>
				</tr>
			</table>
			<button>Submit</button>
		</form>
	</div>

	<!-- quiz reporting --><br />
	<%
		new ReportManager();
		String report = request.getParameter("report");
		if(report != null) {
			ReportManager.reportQuiz(user.getId(), quiz.getQuiz_id(), report);
			out.println("<div class='success'>You have successfully reported this quiz. An administrator will review this.</div><br />");
		}
	%>
	<input type='submit' onclick='showReport()' value='Report as inappropriate' />
	
	<div id='report'>
	<form method="POST">
		<input type='hidden' name='quiz_id' value='<%= quiz.getQuiz_id() %>' />
		<textarea name='report'></textarea>
		<input type='submit' value='Report as inappropriate' />
	</form>
	</div>

	<%
		boolean taken = true;
		if (QuizResult.getBestQuizTakers(quiz.getQuiz_id(), 0).size() == 0) {
			taken = false;
			out.println("<br /><br />Nobody has taken this quiz");
		}
	%>
	</div>
	</div>

	<div class='col-1-4'>
	<div class='pad-left-small'>
	<p class='h3'>Categories:
	<%
		new CatTagManager();
		out.println("<a href='cat_tag.jsp?category="+CatTagManager.getCategoryFromQuiz(quiz.getQuiz_id())+"'>"+CatTagManager.getCategoryFromQuiz(quiz.getQuiz_id())+"</a>");
	%></p>
	
	<p class='h3'>Tags:
	<%
		for(String tag : CatTagManager.getTagsFromQuiz(quiz.getQuiz_id())) {
			out.println("<a href='cat_tag.jsp?tag="+tag+"'>"+tag+"</a>");
		}
	%></p>
	
	<p class='h3'>Quiz Author:
	<a href="profile.jsp?id=<%=quiz.getUser_id()%>"> <%=manager.getAccountById(String.valueOf(quiz.getUser_id()))
					.getUsername()%></a>
	</p>
	
	<p class='h3'>Average Rating:
	<%
		double averageRating = ReviewManager.getAverageRating(ReviewManager.getReviews(quiz.getQuiz_id()));
		if(Double.isNaN(averageRating)) 
			out.println("No ratings");
		else
			out.println(averageRating);
	%></p>
	</div>
	</div>
	
	<div class='col-1-4'>
	<div class='pad-left-small'>
	Share:<br />
	<div>
	<!-- FACEBOOK LIKE BUTTON -->
	<div class="fb-like" data-href="http://localhost:8080/hw6/" data-send="false" data-layout="button_count" data-width="450" data-show-faces="true" data-font="segoe ui"></div>

	<!-- GOOGLE PLUS BUTTON --><br />
	<!-- Place this tag where you want the +1 button to render. -->
	<div class="g-plusone" data-annotation="inline" data-width="300"></div>

	<!-- Place this tag after the last +1 button tag. -->
	<script type="text/javascript">
	  (function() {
	    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
	    po.src = 'https://apis.google.com/js/plusone.js';
	    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
	  })();
	</script>
	
	<!-- TWITTER SHARE BUTTON --><br />
	<a href="https://twitter.com/share" class="twitter-share-button">Tweet</a>
	<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
	</div><br />
	</div>
	</div><!-- end col-1-4 -->
	
	
	<br />
	<br />	
	
<div id='accordion-off' class='clear-both'>	
	<div class='section'>
	<h3><a name='yourPastScores'>Your past scores with this quiz</a></h3>
	<%
		// List of user's past performance on specific quiz
		ArrayList<Result> results = QuizResult.getUserPerformanceOnQuiz(
				taker.getId(), quiz.getQuiz_id());
		listPerformers(out, results, resultsToUsers(results));
	%>
	<br /><a href='#top'>Back to top</a>
	</div>
	
	<div class='section-white'>
	<h3><a name='bestScoresAllTime'>Best scores of all time</a></h3>
	<%
		// List of highest performers of all time
		results = QuizResult.getBestQuizTakers(quiz.getQuiz_id(), 0);
		ArrayList<User> bestAllTime = resultsToUsers(results);
		listPerformers(out, results, bestAllTime);
	%>
	<br /><a href='#top'>Back to top</a>
	</div>
	
	<div class='section'>
	<h3><a name='bestScoresLastDay'>Best scores in the last day</a></h3>
	<%
		// List of recent best scores in the last day
		results = QuizResult.getRecentHighScores(quiz.getQuiz_id(), 0);
		ArrayList<User> bestLastDay = resultsToUsers(results);
		listPerformers(out, results, bestLastDay);
	%>
	<br /><a href='#top'>Back to top</a>
	</div>
	
	<div class='section-white'>
	<h3><a name='recentScores'>Recent quiz scores</a></h3>
	<%
		// List of recent 
		results = QuizResult.getRecentTakers(quiz.getQuiz_id(), 0);
		ArrayList<User> lastDay = resultsToUsers(results);
		listPerformers(out, results, lastDay);
	%>
	<br /><a href='#top'>Back to top</a>
	</div>
	
	<div class='section'>
	<h3><a name='statistics'>Statistics for this quiz</a></h3>
	<div id='table'>
	<%
		ArrayList<Double> numStats = QuizResult.getNumericStatistics(quiz
				.getQuiz_id());
		results = QuizResult.getResultStatistics(quiz.getQuiz_id());
		if (results != null) {
			DecimalFormat df = new DecimalFormat("0%");
			DecimalFormat df2 = new DecimalFormat("#");
			out.println("<div id='row'><div id='left'>Number of users who have taken this quiz:</div><div id='right'>"
					+ (df2.format(numStats.get(QuizResult.NUM_USERS))));
			out.println("</div></div><div id='row'><div id='left'>Number of times this quiz has been taken:</div><div id='right'>"
					+ (df2.format(numStats.get(QuizResult.NUM_TIMES))));
			out.println("</div></div><div id='row'><div id='left'>Average percent correct:</div><div id='right'>"
					+ df.format(numStats.get(QuizResult.AVG_PERCENT)));
			long millis = Math.round(numStats.get(QuizResult.AVG_TIME));
			out.println("</div></div><div id='row'><div id='left'>Average time taken:</div><div id='right'>"
					+ Result.durationString(millis));
			out.println("</div></div><div id='row'><div id='left'>Number of plays since yesterday:</div><div id='right'>"
					+ df2.format((numStats.get(QuizResult.NUM_DAY_PLAYS))));

			String tags[] = { "</div></div><div id='row'><div id='left'>Best Score:</div><div id='right'>",
					"</div></div><div id='row'><div id='left'>Worst Score:</div><div id='right'>", "</div></div><div id='row'><div id='left'>Longest Play:</div><div id='right'>",
					"</div></div><div id='row'><div id='left'>Shortest Play:</div><div id='right'>", "</div></div><div id='row'><div id='left'>Most Recent Play:</div><div id='right'>",
					"</div></div><div id='row'><div id='left'>First Play:</div><div id='right'>" };

			results = QuizResult.getResultStatistics(quiz.getQuiz_id());

			for (int j = 0; j < results.size(); j++) {
				Result rs = results.get(j);
				double dscore;
				if (rs.maxPossiblePoints != 0) {
					dscore = (rs.pointsScored / (double) rs.maxPossiblePoints);
				} else {
					dscore = -1;
				}
				String score = df.format(dscore);
				String userName = manager.getAccountById(
						String.valueOf(rs.userId)).getUsername();

				out.println(tags[j] + score
						+ " by <a href='profile.jsp?id=" + rs.userId + "'>"
						+ userName + "</a> on " + rs.dateString());
			}
			out.println("</div></div></div>");
		}
	%>
	<br /><a href='#top'>Back to top</a>
	</div>
	</div>
	
	<div class='section-white'>
	<h3><a name='ratingsReviews'>Ratings and Reviews for this quiz</a></h3>
		<%
			ArrayList<Review> reviews = ReviewManager.getReviews(quiz.getQuiz_id());
			for(Review newReview : reviews) {
				out.println("<h3>"+manager.getAccountById(String.valueOf(newReview.userId)).getUsername()+" says...</h3>");	
				out.println("<p>"+newReview.text+"</p>");
				out.println("<p>[ Rating: "+newReview.review_score+" ]</p>");
			}
		%>
	<br /><a href='#top'>Back to top</a>
	</div>
</div><!-- end accordion -->
</div><!-- end content -->
</div>

<div class='footer'><div class="pad">Quizzard 2013.</div></div>
</body>
</html>