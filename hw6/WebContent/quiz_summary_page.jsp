<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="site.*, java.util.*,java.sql.*,java.io.*,java.text.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="styles.css">
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.1.1.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
		String date = java.text.DateFormat.getDateTimeInstance().format(
				result.timeStamp);
		try {
			out.println("<tr><td> <a href='profile.jsp?id=" + result.userId
					+ "'>" + user.getUsername() + "</a>" + "</td><td>" + score2
					+ "</td><td>" + result.durationOfQuiz + "</td><td>" + date);
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
			out.println("<table border=\"1\">");
			out.println("<tr><th>User</th><th>Percent Score</th><th>Duration of Quiz</th><th>TimeTaken</th></tr>");
			for (int i = 0; i < res.size(); i++) {
				Result result = res.get(i);
				User user = users.get(i);
				listResult(out, result, user);
			}
			out.println("</table><hr>");
		} catch (IOException ignored) {
		}
	}%>

<%
	// SETUP
	manager = new AccountManager();
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

<title><%=quiz.getTitle()%></title>
</head>
<body>
	<h1>
		<%=quiz.getTitle()%>
		Summary
	</h1>

	<br />
	<div>
		<h3>
		<%
			if(request.getParameter("challenger_id") != null) {
				challenger = manager.getAccountById(request.getParameter("challenger_id"));
			}
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
		%>
		</h3>
	</div>

	Quiz Author:
	<a href="profile.jsp?id=<%=quiz.getUser_id()%>"> <%=manager.getAccountById(String.valueOf(quiz.getUser_id()))
					.getUsername()%></a>
	<p></p>

	<form action="quiz_taker.jsp" method="POST">
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
		<input type="submit" value="Challenge this friend" />
	</form>

	<%
		boolean taken = true;
		if (QuizResult.getBestQuizTakers(quiz.getQuiz_id(), 0).size() == 0) {
			taken = false;
			out.println("<br /><br />Nobody has taken this quiz");
		}
	%>
	<br />
	<div>
		<h3>
			<%
				if (taken) {
					out.println("Your past scores with this quiz:");
				}
			%>
		</h3>
	</div>
	<%
		// List of user's past performance on specific quiz
		ArrayList<Result> results = QuizResult.getUserPerformanceOnQuiz(
				taker.getId(), quiz.getQuiz_id());
		listPerformers(out, results, resultsToUsers(results));
	%>

	<br />
	<div>
		<h3>
			<%
				if (taken) {
					out.println("Best Scores of all time:");
				}
			%>
		</h3>
	</div>
	<%
		// List of highest performers of all time
		results = QuizResult.getBestQuizTakers(quiz.getQuiz_id(), 0);
		ArrayList<User> bestAllTime = resultsToUsers(results);
		listPerformers(out, results, bestAllTime);
	%>
	<br />
	<div>
		<h3>
			<%
				if (taken) {
					out.println("Best Scores in the last day:");
				}
			%>
		</h3>
	</div>
	<%
		// List of recent best scores in the last day
		results = QuizResult.getRecentHighScores(quiz.getQuiz_id(), 0);
		ArrayList<User> bestLastDay = resultsToUsers(results);
		listPerformers(out, results, bestLastDay);
	%>
	<br />
	<div>
		<h3>
			<%
				if (taken) {
					out.println("Recent Quiz Scores");
				}
			%>
		</h3>
	</div>
	<%
		// List of recent 
		results = QuizResult.getRecentTakers(quiz.getQuiz_id(), 0);
		ArrayList<User> lastDay = resultsToUsers(results);
		listPerformers(out, results, lastDay);
	%>
	<br />
	<div>
		<h3>
			<%
				if (taken) {
					out.println("Statistics for this Quiz");
				}
			%>
		</h3>
	</div>
	<%
		ArrayList<Double> numStats = QuizResult.getNumericStatistics(quiz
				.getQuiz_id());
		results = QuizResult.getResultStatistics(quiz.getQuiz_id());
		if (results != null) {
			DecimalFormat df = new DecimalFormat("0%");
			DecimalFormat df2 = new DecimalFormat("#");
			out.println("<p>Number of users who have taken this quiz: "
					+ (df2.format(numStats.get(QuizResult.NUM_USERS))));
			out.println("</p><p>Number of times this quiz has been taken: "
					+ (df2.format(numStats.get(QuizResult.NUM_TIMES))));
			out.println("</p><p>Average Percent Correct: "
					+ df.format(numStats.get(QuizResult.AVG_PERCENT)));
			out.println("</p><p>Average time taken: "
					+ df2.format((numStats.get(QuizResult.AVG_TIME))));
			out.println("</p><p>Number of plays since yesterday: "
					+ df2.format((numStats.get(QuizResult.NUM_DAY_PLAYS))));

			String tags[] = { "</p><p>Best Score: ",
					"</p><p>Worst Score: ", "</p><p>Longest Play: ",
					"</p><p>Shortest Play: ", "</p><p>Most Recent Play: ",
					"</p><p>First Play: " };

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
			out.println("</p>");
		}
	%>

	<%
		out.println("<a href='index.jsp?id=" + taker.getId()
				+ "'>My Homepage</a><br />");
	%>
	<a href="make_quiz.jsp">Make a Quiz</a>
	<br />
	<%
		out.println("<a href='profile.jsp?id=" + taker.getId()
				+ "'>My profile</a><br />");
	%>
	<%
		out.println("<a href='inbox.jsp'>My inbox</a><br />");
	%>
	<a href="logout.jsp">Logout</a>

</body>
</html>