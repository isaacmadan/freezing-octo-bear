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

<!-- NO TOUCH - USER AUTH CODE -->
<%
	if(session == null) {
		RequestDispatcher dispatch = request.getRequestDispatcher("index.jsp");
		dispatch.forward(request, response);
		return;
	}
	
	User thisUser = (User)session.getAttribute("user");
	if(thisUser == null) {
		RequestDispatcher dispatch = request.getRequestDispatcher("unauthorized.jsp");
		dispatch.forward(request, response);
		return;
	}
%>
<!-- END -->

<%
	AccountManager manager = new AccountManager();
	//User thisUser = (User)session.getAttribute("user");
	//if(thisUser == null) {
	//	out.println("You have to be logged in to view profiles.");
	//	return;
	//}
	
	String user_id = request.getParameter("id");
	if(user_id == null || user_id.equals(""))
		return;
	User user = manager.getAccountById(user_id);
	boolean myProfile = false;
	if(user != null) {
		if(thisUser != null && user.getId() == thisUser.getId()) {
			//out.println("You're viewing your own profile.<br />");
			myProfile = true;
		}
	}
%>

<title><%= user.getUsername() %>'s profile</title>
</head>
<body>

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

<%
	new AdminControl();
	if(AdminControl.isAdmin(thisUser.getId())) {
		out.println("<div class='admin'>");
		out.println("<div class='pad pad-vertical'>");
		out.println("<h2>Admin Controls</h2>");
		out.println("<button id='deleteUser' onclick='deleteUser(" + user.getId() + ")'>Delete this user</button>");
		if(AdminControl.isAdmin(user.getId()))
			out.println("<button id='demoteUser' onclick='demoteUser("+thisUser.getId()+", "+user.getId()+")'>Demote this user</button>");
		else
			out.println("<button id='demoteUser' onclick='promoteUser("+thisUser.getId()+", "+user.getId()+")'>Promote this user</button>");
		out.println("</div>");
		out.println("</div>");
	}
%>


<div class='col-1-5'>
<h2>Friends</h2>
<%
	HashSet<Integer> friends = manager.getFriends(Integer.parseInt(user_id));
	for(Integer id : friends) {
		out.println("<a href='profile.jsp?id="+manager.getAccountById(String.valueOf(id)).getId()+"'>"+
		manager.getAccountById(String.valueOf(id)).getUsername()+"</a><br />");
	}
	if(friends.size() == 0 ) {
		out.println("<p>No friends</p>");
	}
%>

<form action="add_friend.jsp" method="POST">
	<input type="hidden" name="x_id" value="<%= thisUser.getId() %>" />
	<input type="hidden" name="y_id" value="<%= user.getId() %>" />
	<% 
	if(!myProfile) {
		if(manager.areFriends(thisUser.getId(), user.getId())) {
			out.println("<input type='hidden' name='unfriend' value='true' />");
			out.println("<input type='submit' value='Remove as friend' />");
		}
		else {
			out.println("<input type='submit' value='Add as friend' />");
		}
	}
	%>
</form>
</div>

<div class="col-3-5">
<h2>History</h2>
<div class='pad-right'>
<div id='table'>
<div id='row' class='th'><div id='left'>Date</div><div id='right'>Quiz name</div><div id='right'>Score</div><div id='right'>Duration</div></div>
<%
	QuizManager quizManager = new QuizManager();	

	ArrayList<Result> results = QuizResult.getUserPerformances(user.getId(), "BY_DATE");	
	for(Result result : results) {
		Quiz quiz = quizManager.getQuizByQuizId(result.quizId);
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
</div>
</div>
</div>

<div class="col-1-5">
<h2>Achievements</h2>
<%
	Achievements achievements = manager.getAchievements(user.getId());
	ArrayList<String> achievementStrings = achievements.getStrings(); 
	for(String achievement : achievementStrings) {
		out.println(achievement+"<br />");
	}
	if(achievementStrings.size() == 0 ) {
		out.println("<p>No achievements</p>");
	}
%>
</div>


</div>
</div>
<div class='footer'><div class="pad">Quizzard 2013.</div></div>
</body>
</html>