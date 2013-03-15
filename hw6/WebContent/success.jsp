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
<div class="header"><a href='index.jsp'>QUIZZARD</a>

	<ul class='menu'>
		<li><a href = "make_quiz.jsp">Make a quiz</a></li>
		<li><% out.println("<a href='profile.jsp?id="+user.getId()+"'>My public profile</a>"); %></li>
		<li><% out.println("<a href='inbox.jsp'>My inbox</a>"); %></li>
		<li><% out.println("<a href='history.jsp'>My performance history</a>"); %></li>
		<li><a href="logout.jsp">Logout</a></li>
	</ul>
	
</div>
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

Popular quizzes
Recently created quizzes
My recent quiz taking
My recent quiz creation
Achievements
Messages
Recent friends' activities

<h3>Admin News</h3>
<div>
<table border='1'>
<tr><th>Date</th><th>Posted By</th><th>Announcement</th></tr>
<%
	AccountManager accountManager = new AccountManager();
	new AdminControl();
	ArrayList<Announcement> announcements = new ArrayList<Announcement>();
	try { 
		announcements = AdminControl.getAnnouncements(10);
		for(Announcement announcement : announcements) {
			out.println("<tr><td>"+announcement.dateString()+"</td>"+
					"<td><a href='profile.jsp?id="+
					announcement.user_id+"'>"+
					accountManager.getAccountById(String.valueOf(announcement.user_id)).getUsername()+"</a></td>"+
					"<td>"+announcement.text+"</td></tr>");
		}
	}
	catch(Exception e) { System.out.println(e); }
%>
</table>

<br />
<%
	if(AdminControl.isAdmin(user.getId())) {
		out.println("<button onclick='announcerInit()'>Make an announcement</button>");
	
		out.println("<div id='announcer'>Announcement:<br /><form action='admin.jsp' method='POST'><textarea rows='10' cols='10' name='text'></textarea><input type='hidden' name='user_id' value='"+user.getId()+"' /><input type='submit' /></form></div>");
	}
%>
</div>

<!-- quizzard statistics - admin only -->
<%
	if(AdminControl.isAdmin(user.getId())) {
		out.println("<h3>Quizzard Statistics</h3>");
		out.println("<div>");
		out.println("<table border='1'>");
		out.println("<tr><th>Statistic</th><th>Value</th></tr>");
	
		try {
		ArrayList<Statistic> statistics = AdminControl.getStatistics();
		for(Statistic statistic : statistics) {
			out.println("<tr><td>"+statistic.description+"</td><td>"+statistic.stat+"</td></tr>");
		}
		} catch(Exception e) {}
		
		out.println("</table>");
		out.println("</div>");
	}
%>

<!-- reporting - admin only -->
<%
	if(AdminControl.isAdmin(user.getId())) {
		out.println("<h3>Reported Quizzes</h3>");
		out.println("<div>");
		out.println("<table border='1'>");
		out.println("<tr><th>Reported on</th><th>Reported by</th><th>Report text</th><th>Quiz name</th><th>Quiz description</th><th>Quiz creator</th><th>Delete report</th></tr>");
		new ReportManager();
		QuizManager manager = new QuizManager();
		ArrayList<Report> reports = ReportManager.getReportedQuizzes();
		for(Report report : reports) {
			User reportingUser = accountManager.getAccountById(String.valueOf(report.userId));
			Quiz offendingQuiz = manager.getQuizByQuizId(report.quizId);
			User offendingUser = accountManager.getAccountById(String.valueOf(offendingQuiz.getUser_id()));
			out.println("<tr><td>"+report.dateString()+"</td>"+
						"<td><a href='profile.jsp?id="+reportingUser.getId()+"'>"+reportingUser.getUsername()+"</a></td>"+
						"<td>"+report.text+"</td>"+
						"<td><a href='quiz_summary_page.jsp?quiz_id="+offendingQuiz.getQuiz_id()+"'>"+offendingQuiz.getTitle()+"</a></td>"+
						"<td>"+offendingQuiz.getDescription()+"</td>"+
						"<td><a href='profile.jsp?id="+offendingUser.getId()+"'>"+offendingUser.getUsername()+"</a></td>"+
						"<td>"+"<form method='POST'><input type='hidden' name='delete_report' value='"+report.reportId+"' /><input type='submit' value='Delete report' /></form>"+"</td>"+
						"</tr>");
		}
		out.println("</table>");
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

<h3>Popular Quizzes</h3>
<div>
<table border="1">
<tr><th>Date</th><th>Quiz name</th><th>Description</th><th>Created by</th></tr>
<%
	new QuizResult();
	ArrayList<Quiz> popularQuizzes  = QuizResult.getPopularQuizzes(0);
	
	int length = 10;
	if(popularQuizzes.size() < length) length = popularQuizzes.size();
	for(int i = 0; i < length; i++) {
		Quiz quiz = popularQuizzes.get(i);
		if(quiz == null)
			out.println("<tr><td>NULL</td><td>NULL</td><td>NULL</td><td>NULL</td></tr>");
		else
			out.println("<tr><td>"+quiz.getCreated_timestamp()+"</td><td><a href='quiz_summary_page.jsp?quiz_id="+quiz.getQuiz_id()+"'>"+quiz.getTitle()+"</a></td><td>"+quiz.getDescription()+"</td><td><a href='profile.jsp?id="+accountManager.getAccountById(String.valueOf(quiz.getUser_id())).getId()+"'>"+accountManager.getAccountById(String.valueOf(quiz.getUser_id())).getUsername()+"</a></td></tr>");
	}
%>
</table>
</div>

<h3>Recently Created Quizzes</h3>
<div>
<table border="1">
<tr><th>Date</th><th>Quiz name</th><th>Description</th><th>Created by</th></tr>
<%
	QuizManager manager = new QuizManager();
	ArrayList<Quiz> recentQuizzes  = manager.getRecentWholeQuizTableByDate(7); //7 days
	
	length = 10;
	if(recentQuizzes.size() < length) length = recentQuizzes.size();
	for(int i = 0; i < length; i++) {
		Quiz quiz = recentQuizzes.get(i);
		if(quiz == null)
			out.println("<tr><td>NULL</td><td>NULL</td><td>NULL</td><td>NULL</td></tr>");
		else {
			try {
				out.println("<tr><td>"+quiz.getCreated_timestamp()+
							"</td><td><a href='quiz_summary_page.jsp?quiz_id="+quiz.getQuiz_id()+
							"'>"+quiz.getTitle()+"</a></td><td>"+quiz.getDescription()+
							"</td><td><a href='profile.jsp?id="+
							accountManager.getAccountById(String.valueOf(quiz.getUser_id())).getId()+
							"'>"+accountManager.getAccountById(String.valueOf(quiz.getUser_id())).getUsername()+
							"</a></td></tr>");
			}
			catch(Exception e) { System.out.println(e); }
		}
	}
%>
</table>
</div>

<h3>My Recent Quiz Taking Activities</h3>
<div>
<table border="1">
<tr><th>Date</th><th>Quiz name</th><th>Score</th><th>Duration</th></tr>
<%
	ArrayList<Result> results = QuizResult.getRecentUserPerformances(user.getId(), 7); //7 days
	for(Result result : results) {
		Quiz quiz = manager.getQuizByQuizId(result.quizId);
		String titleString = String.valueOf(result.quizId);
		if(quiz != null) {
			titleString = quiz.getTitle();
		}
		out.println("<tr><td>"+result.timeStamp+"</td><td><a href='quiz_summary_page.jsp?quiz_id="+result.quizId+"'>"
					+titleString+"</a></td><td>"+result.pointsScored+"/"+result.maxPossiblePoints+"</td><td>"
					+result.durationString()+"</td></tr>");
	}
	if(results.size() == 0) {
		out.println("No quiz results");
	}
%>
</table>
</div>

<h3>My Recent Quiz Creating Activities</h3>
<div>
<table border="1">
<tr><th>Date</th><th>Quiz name</th><th>Quiz Description</th></tr>
<%
	//ArrayList<Quiz> quizzes = manager.getQuizzesByUserId(user.getId());	
	ArrayList<Quiz> quizzes = manager.getRecentQuizzesByUserId(user.getId(), 7); //7 days	
	for(Quiz quiz : quizzes) {
		out.println("<tr><td>"+quiz.getCreated_timestamp()+"</td><td><a href='quiz_summary_page.jsp?quiz_id="+quiz.getQuiz_id()+"'>"+quiz.getTitle()+"</a></td><td>"+quiz.getDescription()+"</td></tr>");
	}
	if(results.size() == 0) {
		out.println("No quiz results");
	}
%>
</table>
</div>

<h3>Achievements</h3>
<div>
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
</div>

<h3>Messages</h3>
<div>
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
</div>

<h3>Recent Friends' Activities</h3>
<div class='inner'>
<%
	HashSet<Integer> friendsIds = accountManager.getFriends(user.getId());
	for(Integer friendId : friendsIds) {
		User friend = accountManager.getAccountById(String.valueOf(friendId));
		out.println("<h3><a href='profile.jsp?id="+friend.getId()+"'>"+friend.getUsername()+"</a></h3>");
		out.println("<ul>");
		ArrayList<Result> friendResults = QuizResult.getRecentUserPerformances(friend.getId(), 7); //7 days
		out.println("<li>Recently took ");
		for(int i = 0; i < friendResults.size(); i++) {
			Result result = friendResults.get(i);
			Quiz quiz = manager.getQuizByQuizId(result.quizId);
			String titleString = String.valueOf(result.quizId);
			if(quiz != null) {
				titleString = quiz.getTitle();
			}
			if(i == friendResults.size()-1)
				out.println("<a href='quiz_summary_page.jsp?quiz_id="+result.quizId+"'>"+titleString+"</a>");
			else
				out.println("<a href='quiz_summary_page.jsp?quiz_id="+result.quizId+"'>"+titleString+"</a>"+", ");
		}
		if(friendResults.size() == 0) {
			out.println(" no quizzes");
		}
		out.println("<br />");
		ArrayList<Quiz> friendQuizzes = manager.getRecentQuizzesByUserId(friend.getId(), 7); //7 days	
		out.println("</li><li>Recently created ");
		for(int i = 0; i < friendQuizzes.size(); i++) {
			Quiz quiz = friendQuizzes.get(i);
			if(i == friendQuizzes.size()-1)
				out.println("<a href='quiz_summary_page.jsp?quiz_id="+quiz.getQuiz_id()+"'>"+quiz.getTitle()+"</a>");
			else
				out.println("<a href='quiz_summary_page.jsp?quiz_id="+quiz.getQuiz_id()+"'>"+quiz.getTitle()+"</a>"+", ");
		}
		if(friendQuizzes.size() == 0) {
			out.println("no quizzes");
		}
		out.println("<br />");
		Achievements friendAchievements = accountManager.getRecentAchievements(friend.getId(), 7); //7 days
		ArrayList<String> friendAchievementsStrings = friendAchievements.getStrings();
		out.println("</li><li>Earned ");
		for(int i = 0; i < friendAchievementsStrings.size(); i++) {
			String str = friendAchievementsStrings.get(i);
			if(i == friendAchievementsStrings.size()-1)
				out.println(str);
			else
				out.println(str+", ");
		}
		if(friendAchievementsStrings.size() == 0)
			out.println("no recent achievements");
		out.println("</li></ul>");
	}
%>
</div>

</div><!-- end of accordion div -->
</div><!-- end of content div -->
</div>

<div class='footer'><div class="pad">Quizzard 2013.</div></div>
</body>
</html>