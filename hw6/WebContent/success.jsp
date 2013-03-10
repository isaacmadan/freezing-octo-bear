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
<link href='http://fonts.googleapis.com/css?family=Merriweather' rel='stylesheet' type='text/css'>
<script src="site.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome to freezing-octo-bear!</title>
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

<div class="header"><div class="pad"><a href='index.jsp'>Quizzard</a></div></div>

<div class="nav">
	<div id="links">
	<ul>
		<li><a href = "make_quiz.jsp">Make a Quiz</a></li>
		<li><% out.println("<a href='profile.jsp?id="+user.getId()+"'>My public profile</a>"); %></li>
		<li><% out.println("<a href='inbox.jsp'>My inbox</a>"); %></li>
		<li><% out.println("<a href='history.jsp'>My performance history</a>"); %></li>
		<li><a href="logout.jsp">Logout</a></li>
	</ul>
	</div>
</div>

<div class='subheader'>
<div class="pad">
<%= user.getUsername() %>
<div id='search'>
	<form action="search.jsp" method="GET">
		<input type="text" name="query" />
		<input type="submit" value="Search" />
	</form>
</div>
</div>
</div>

<div class='content'>
<div id="accordion">

<h3>Admin News</h3>
<div>
<table>
<tr><th>Date</th><th>Posted By</th><th>Announcement</th></tr>
<%
	AccountManager accountManager = new AccountManager();
	new AdminControl();
	ArrayList<Announcement> announcements = new ArrayList<Announcement>();
	try { 
		announcements = AdminControl.getAnnouncements(10);
		for(Announcement announcement : announcements) {
			out.println("<tr><td>"+announcement.dateString()+"</td>"+
					"<td>"+accountManager.getAccountById(String.valueOf(announcement.user_id)).getUsername()+"</td>"+
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
	ArrayList<Quiz> recentQuizzes  = manager.getWholeQuizTableByDate();
	
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
	ArrayList<Result> results = QuizResult.getUserPerformances(user.getId(), "BY_DATE");	
	for(Result result : results) {
		Quiz quiz = manager.getQuizByQuizId(result.quizId);
		String titleString = String.valueOf(result.quizId);
		if(quiz != null) {
			titleString = quiz.getTitle();
		}
		out.println("<tr><td>"+result.timeStamp+"</td><td><a href='quiz_summary_page.jsp?quiz_id="+result.quizId+"'>"
					+titleString+"</a></td><td>"+result.pointsScored+"/"+result.maxPossiblePoints+"</td><td>"
					+result.durationOfQuiz+"</td></tr>");
		
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
	ArrayList<Quiz> quizzes = manager.getQuizzesByUserId(user.getId());	
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
		ArrayList<TextMessage> messages = Inbox.getRecentMessagesById(user.getId(), 3);
		out.println("You've received "+messages.size()+" new messages in the past 3 days.<br />");
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
<div>
<%
	HashSet<Integer> friendsIds = accountManager.getFriends(user.getId());
	for(Integer friendId : friendsIds) {
		User friend = accountManager.getAccountById(String.valueOf(friendId));
		out.println("<h4>"+friend.getUsername()+"</h4>");
		Achievements friendAchievements = accountManager.getAchievements(friend.getId());
		ArrayList<String> friendAchievementsStrings = friendAchievements.getStrings();
		out.println("Earned: ");
		for(String str : friendAchievementsStrings) {
			out.println(str);
		}
	}
%>
</div>

</div><!-- end of accordion div -->
</div><!-- end of content div -->

<div class='footer'><div class="pad">Quizzard 2013.</div></div>
</body>
</html>