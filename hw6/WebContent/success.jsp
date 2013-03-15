<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="site.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="styles.css">
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.1.1.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />
<link href='http://fonts.googleapis.com/css?family=Patrick+Hand+SC|Sintony|Merriweather|Merriweather+Sans' rel='stylesheet' type='text/css'>
<script src="site.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Quizzard - Dashboard</title>
</head>
<body>

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
<div id="accordion-off">

<div class='section-white no-border'>
<h3><a name='top'>Menu</a></h3>
<% 
	new AdminControl();
	if(AdminControl.isAdmin(user.getId())) {
		out.println("<p><a href='#adminTools'>Admin tools</a></p>");
	}
%>	
<p><a href='#adminNews'>Admin news</a></p>
<% 
	if(AdminControl.isAdmin(user.getId())) {
		out.println("<p><a href='#quizzardStatistics'>Quizzard statistics</a></p>");
		out.println("<p><a href='#reportedQuizzes'>Reported quizzes</a></p>");
	}
%>	
<p><a href='#popularQuizzes'>Popular quizzes</a></p>
<p><a href='#recentCreated'>Recently created quizzes</a></p>
<p><a href='#recentTaken'>My recent quiz taking</a></p>
<p><a href='#myRecentCreated'>My recent quiz creation</a></p>
<p><a href='#achievements'>Achievements</a></p>
<p><a href='#messages'>Messages</a></p>
<p><a href='#recentFriends'>Recent friends' activities</a></p>
</div>

<!-- admin tools -->
<% 
	new CatTagManager();
	String newCategory = request.getParameter("new_category");
	if(newCategory != null) {
		CatTagManager.createCategory(newCategory);
	}
	
	String deleteCategory = request.getParameter("delete_category");
	if(deleteCategory != null) {
		CatTagManager.deleteCategory(deleteCategory);
	}
	
	if(AdminControl.isAdmin(user.getId())) {
		out.println("<div class='section-white'>");
		out.println("<h3><a name='adminTools'>Admin Tools</a></h3>");
		
		out.println("<h4>Manage categories</h3>");
		out.println("<form action='success.jsp' method='POST'>");
		out.println("<div id='table'><div id='row'><div id='left'><input type='text' name='new_category' /></div>");
		out.println("<div id='right'><input type='submit' value='Add' /></div></div>");
		out.println("</form>");
		
		out.println("<form action='success.jsp' method='POST'>");
		out.println("<div id='row'><div id='left'><select name='delete_category'>");
		ArrayList<String> categories = CatTagManager.getCategories();
		for(String category : categories) {
			out.println("<option value='"+category+"'>"+category+"</option>");
		}
		out.println("</select></div>");
		out.println("<div id='right'><input type='submit' value='Delete' /></div></div></div>");
		out.println("</form>");
		out.println("</div>");
	}
%>	

<div class='section'>
<h3><a name='adminNews'>Admin News</a></h3>

<div id='table'>
<div id='row-td'><div id='left'>Date</div><div id='left'>Posted By</div><div id='left'>Announcement</div></div>
<%
	AccountManager accountManager = new AccountManager();
	new AdminControl();
	ArrayList<Announcement> announcements = new ArrayList<Announcement>();
	try { 
		announcements = AdminControl.getAnnouncements(10);
		for(Announcement announcement : announcements) {
			out.println("<div id='row'><div id='left'>"+announcement.dateString()+"</div>"+
					"<div id='right'><a href='profile.jsp?id="+
					announcement.user_id+"'>"+
					accountManager.getAccountById(String.valueOf(announcement.user_id)).getUsername()+"</a></div>"+
					"<div id='right'>"+announcement.text+"</div></div>");
		}
	}
	catch(Exception e) { System.out.println(e); }
%>
</div>
<br />
<%
	if(AdminControl.isAdmin(user.getId())) {
		out.println("<button onclick='announcerInit()'>Make an announcement</button>");
	
		out.println("<div id='announcer'>Announcement:<br /><form action='admin.jsp' method='POST'><textarea rows='10' cols='10' name='text'></textarea><input type='hidden' name='user_id' value='"+user.getId()+"' /><input type='submit' /></form></div>");
	}
%>

<br /><br />
<p><a href='#top'>Back to top</a></p>
</div>

<!-- quizzard statistics - admin only -->
<%
	if(AdminControl.isAdmin(user.getId())) {
		out.println("<div class='section-white'>");
		out.println("<h3><a name='quizzardStatistics'>Quizzard Statistics</a></h3>");
		out.println("<div id='table'>");
		out.println("<div id='row-td'><div id='left'>Statistic</div><div id='left'>Value</div></div>");
	
		try {
		ArrayList<Statistic> statistics = AdminControl.getStatistics();
		for(Statistic statistic : statistics) {
			out.println("<div id='row'><div id='left'>"+statistic.description+"</div><div id='right'>"+statistic.stat+"</div></div>");
		}
		} catch(Exception e) {}
		
		out.println("</div><br />");
		out.println("<p><a href='#top'>Back to top</a></p>");
		out.println("</div>");
	}
%>

<!-- reporting - admin only -->
<%
	if(AdminControl.isAdmin(user.getId())) {
		out.println("<div class='section reported'>");
		out.println("<h3><a name='reportedQuizzes'>Reported Quizzes</a></h3>");
		out.println("<div id='table'>");
		out.println("<div id='row-td'><div id='left'>Reported on</div><div id='left'>Reported by</div><div id='left'>Report text</div><div id='left'>Quiz name</div><div id='left'>Quiz description</div><div id='left'>Quiz creator</div><div id='left'>Delete report</div></div>");
		new ReportManager();
		QuizManager manager = new QuizManager();
		ArrayList<Report> reports = ReportManager.getReportedQuizzes();
		for(Report report : reports) {
			User reportingUser = accountManager.getAccountById(String.valueOf(report.userId));
			Quiz offendingQuiz = manager.getQuizByQuizId(report.quizId);
			User offendingUser = accountManager.getAccountById(String.valueOf(offendingQuiz.getUser_id()));
			out.println("<div id='row'><div id='left'>"+report.dateString()+"</div>"+
						"<div id='left'><a href='profile.jsp?id="+reportingUser.getId()+"'>"+reportingUser.getUsername()+"</a></div>"+
						"<div id='right'>"+report.text+"</div>"+
						"<div id='right'><a href='quiz_summary_page.jsp?quiz_id="+offendingQuiz.getQuiz_id()+"'>"+offendingQuiz.getTitle()+"</a></div>"+
						"<div id='right'>"+offendingQuiz.getDescription()+"</div>"+
						"<div id='right'><a href='profile.jsp?id="+offendingUser.getId()+"'>"+offendingUser.getUsername()+"</a></div>"+
						"<div id='right'>"+"<form action='success.jsp' method='POST'><input type='hidden' name='delete_report' value='"+report.reportId+"' /><input type='submit' value='Delete report' /></form>"+"</div>"+
						"</div>");
		}
		out.println("</div><br />");
		out.println("<p><a href='#top'>Back to top</a></p>");
		out.println("</div>");
	}
%>

<!-- process report deletion -->
<%
	String deleteReport = request.getParameter("delete_report");
	if(deleteReport != null) {
		ReportManager.removeReport(Integer.parseInt(deleteReport));
	}
%>

<div class='section-white'>
<h3><a name='popularQuizzes'>Popular Quizzes</a></h3>
<div id='table'>
<div id='row-td'><div id='left'>Date</div><div id='left'>Quiz name</div><div id='left'>Description</div><div id='left'>Created by</div></div>
<%
	new QuizResult();
	ArrayList<Quiz> popularQuizzes  = QuizResult.getPopularQuizzes(0);
	
	int length = 10;
	if(popularQuizzes.size() < length) length = popularQuizzes.size();
	for(int i = 0; i < length; i++) {
		Quiz quiz = popularQuizzes.get(i);
		if(quiz == null)
			out.println("<div id='row'><div id='left'>NULL</div><div id='right'>NULL</div><div id='right'>NULL</div><div id='right'>NULL</div></div>");
		else
			out.println("<div id='row'><div id='left'>"+quiz.dateString()+"</div><div id='right'><a href='quiz_summary_page.jsp?quiz_id="+quiz.getQuiz_id()+"'>"+quiz.getTitle()+"</a></div><div id='right'>"+quiz.getDescription()+"</div><div id='right'><a href='profile.jsp?id="+accountManager.getAccountById(String.valueOf(quiz.getUser_id())).getId()+"'>"+accountManager.getAccountById(String.valueOf(quiz.getUser_id())).getUsername()+"</a></div></div>");
	}
%>
</div><br />
<p><a href='#top'>Back to top</a></p>
</div>

<div class='section'>
<h3><a name='recentCreated'>Recently Created Quizzes</a></h3>
<div id='table'>
<div id='row-td'><div id='left'>Date</div><div id='left'>Quiz name</div><div id='left'>Description</div><div id='left'>Created by</div></div>
<%
	QuizManager manager = new QuizManager();
	ArrayList<Quiz> recentQuizzes  = manager.getRecentWholeQuizTableByDate(7); //7 days
	
	length = 10;
	if(recentQuizzes.size() < length) length = recentQuizzes.size();
	for(int i = 0; i < length; i++) {
		Quiz quiz = recentQuizzes.get(i);
		if(quiz == null)
			out.println("<div id='row'><div id='left'>NULL</div><div id='right'>NULL</div><div id='right'>NULL</div><div id='right'>NULL</div></div>");
		else {
			try {
				out.println("<div id='row'><div id='left'>"+quiz.dateString()+
							"</div><div id='right'><a href='quiz_summary_page.jsp?quiz_id="+quiz.getQuiz_id()+
							"'>"+quiz.getTitle()+"</a></div><div id='right'>"+quiz.getDescription()+
							"</div><div id='right'><a href='profile.jsp?id="+
							accountManager.getAccountById(String.valueOf(quiz.getUser_id())).getId()+
							"'>"+accountManager.getAccountById(String.valueOf(quiz.getUser_id())).getUsername()+
							"</a></div></div>");
			}
			catch(Exception e) { System.out.println(e); }
		}
	}
%>
</div><br />
<p><a href='#top'>Back to top</a></p>
</div>

<div class='section-white'>
<h3><a name='recentTaken'>My Recent Quiz Taking Activities</a></h3>
<div id='table'>
<div id='row-td'><div id='left'>Date</div><div id='left'>Quiz name</div><div id='left'>Score</div><div id='left'>Duration</div></div>
<%
	ArrayList<Result> results = QuizResult.getRecentUserPerformances(user.getId(), 7); //7 days
	for(Result result : results) {
		Quiz quiz = manager.getQuizByQuizId(result.quizId);
		String titleString = String.valueOf(result.quizId);
		if(quiz != null) {
			titleString = quiz.getTitle();
		}
		out.println("<div id='row'><div id='left'>"+result.dateString()+"</div><div id='right'><a href='quiz_summary_page.jsp?quiz_id="+result.quizId+"'>"
					+titleString+"</a></div><div id='right'>"+result.pointsScored+"/"+result.maxPossiblePoints+"</div><div id='right'>"
					+result.durationString()+"</div></div>");
	}
	if(results.size() == 0) {
		out.println("No quiz results");
	}
%>
</div><br />
<p><a href='#top'>Back to top</a></p>
</div>

<div class='section'>
<h3><a name='myRecentCreated'>My Recent Quiz Creating Activities</a></h3>
<div id='table'>
<div id='row-td'><div id='left'>Date</div><div id='left'>Quiz name</div><div id='left'>Quiz Description</div></div>
<%
	//ArrayList<Quiz> quizzes = manager.getQuizzesByUserId(user.getId());	
	ArrayList<Quiz> quizzes = manager.getRecentQuizzesByUserId(user.getId(), 7); //7 days	
	for(Quiz quiz : quizzes) {
		out.println("<div id='row'><div id='left'>"+quiz.dateString()+"</div><div id='right'><a href='quiz_summary_page.jsp?quiz_id="+quiz.getQuiz_id()+"'>"+quiz.getTitle()+"</a></div><div id='right'>"+quiz.getDescription()+"</div></div>");
	}
	if(results.size() == 0) {
		out.println("No quiz results");
	}
%>
</div><br />
<p><a href='#top'>Back to top</a></p>
</div>

<div class='section-white'>
<h3><a name='achievements'>Achievements</a></h3>
<%
accountManager.updateAchievements(user.getId());
Achievements achievements = accountManager.getAchievements(user.getId());
ArrayList<String> achievementsStrings = achievements.getStrings();
for(String achievement : achievementsStrings) {
	out.println(achievement+"<br />");
}
if(achievementsStrings.size() == 0)
	out.println("No achievements");
%>
<br />
<p><a href='#top'>Back to top</a></p>
</div>

<div class='section'>
<h3><a name='messages'>Messages</a></h3>
	<%
		//AccountManager manager = new AccountManager();
		ArrayList<TextMessage> messages = Inbox.getRecentMessagesById(user.getId(), 7);
		out.println("You've received "+messages.size()+" new messages in the past 7 days.<br />");
		int numNotes = 0;
		int numChallenges = 0;
		int numFriendRequests = 0;
		if(messages.size() > 0) {
			for(TextMessage message : messages) {
				if(message.getMessageType() == 1) numFriendRequests++;
				if(message.getMessageType() == 2) numChallenges++;
				if(message.getMessageType() == 3) numNotes++;
			}
			out.println("("+numFriendRequests+" Friend Requests, "+numChallenges+" Challenges, and "+numNotes+" Notes)");
		}
	%>
	<br /><br />
	<p><a href='#top'>Back to top</a></p>
</div>

<div class='inner section-white'>
<h3><a name='recentFriends'>Recent Friends' Activities</a></h3>
<%
	HashSet<Integer> friendsIds = accountManager.getFriends(user.getId());
	for(Integer friendId : friendsIds) {
		User friend = accountManager.getAccountById(String.valueOf(friendId));
		out.println("<h3><a href='profile.jsp?id="+friend.getId()+"'>"+friend.getUsername()+"</a></h3>");
		out.println("<ul>");
		ArrayList<Result> friendResults = QuizResult.getRecentUserPerformances(friend.getId(), 7); //7 days
		out.println("<li>&#8226; Took ");
		int limit = 10;
		boolean anyLeft = false;
		if(friendResults.size() < limit) limit = friendResults.size();
		if(friendResults.size() > 10) anyLeft = true;
		for(int i = 0; i < limit; i++) {
			Result result = friendResults.get(i);
			Quiz quiz = manager.getQuizByQuizId(result.quizId);
			String titleString = String.valueOf(result.quizId);
			if(quiz != null) {
				titleString = quiz.getTitle();
			}
			if(i == limit-1) {
				if(anyLeft)
					out.println("<a href='quiz_summary_page.jsp?quiz_id="+result.quizId+"'>"+titleString+"</a> and more");
				else
					out.println("<a href='quiz_summary_page.jsp?quiz_id="+result.quizId+"'>"+titleString+"</a>");
			}
			else
				out.println("<a href='quiz_summary_page.jsp?quiz_id="+result.quizId+"'>"+titleString+"</a>"+", ");
		}
		if(friendResults.size() == 0) {
			out.println(" no quizzes");
		}
		out.println("<br />");
		ArrayList<Quiz> friendQuizzes = manager.getRecentQuizzesByUserId(friend.getId(), 7); //7 days	
		out.println("</li><li>&#8226; Created ");
		limit = 10;
		anyLeft = false;
		if(friendQuizzes.size() < limit) limit = friendQuizzes.size();
		if(friendQuizzes.size() > 10) anyLeft = true;
		for(int i = 0; i < limit; i++) {
			Quiz quiz = friendQuizzes.get(i);
			if(i == limit-1) {
				if(anyLeft)
					out.println("<a href='quiz_summary_page.jsp?quiz_id="+quiz.getQuiz_id()+"'>"+quiz.getTitle()+"</a> and more");
				else
					out.println("<a href='quiz_summary_page.jsp?quiz_id="+quiz.getQuiz_id()+"'>"+quiz.getTitle()+"</a>");
			}
			else
				out.println("<a href='quiz_summary_page.jsp?quiz_id="+quiz.getQuiz_id()+"'>"+quiz.getTitle()+"</a>"+", ");
		}
		if(friendQuizzes.size() == 0) {
			out.println("no quizzes");
		}
		out.println("<br />");
		Achievements friendAchievements = accountManager.getRecentAchievements(friend.getId(), 7); //7 days
		ArrayList<String> friendAchievementsStrings = friendAchievements.getStrings();
		out.println("</li><li>&#8226; Earned ");
		/**
		for(int i = 0; i < friendAchievementsStrings.size(); i++) {
			String str = friendAchievementsStrings.get(i);
			if(i == friendAchievementsStrings.size()-1)
				out.println(str);
			else
				out.println(str+", ");
		}
		**/
		if(friendAchievementsStrings.size() == 0)
			out.println("no recent achievements");
		else
			out.println("a recent achievement");
		out.println("</li></ul>");
	}
%>
<br />
<p><a href='#top'>Back to top</a></p>
</div>

</div><!-- end of accordion div -->
</div><!-- end of content div -->
</div>

<div class='footer'><div class="pad">Quizzard 2013.</div></div>
</body>
</html>