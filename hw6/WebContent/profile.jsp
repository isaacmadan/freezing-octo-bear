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

<%
	AccountManager manager = new AccountManager();
	User thisUser = (User)session.getAttribute("user");
	if(thisUser == null) {
		out.println("You have to be logged in to view profiles.");
		return;
	}
	
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

<div class="header"><a href='index.jsp'>Quizzard</a></div>

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

<div class='subheader'><%= user.getUsername() %></div>

<div class='content'>

<div class="admin">

<%
	new AdminControl();
	out.println("<h2>Admin Controls</h2>");
	if(AdminControl.isAdmin(thisUser.getId())) {
		out.println("<button id='deleteUser' onclick='deleteUser(" + user.getId() + ")'>Delete this user</button>");
		if(AdminControl.isAdmin(user.getId()))
			out.println("<button id='demoteUser' onclick='demoteUser("+thisUser.getId()+", "+user.getId()+")'>Demote this user</button>");
		else
			out.println("<button id='demoteUser' onclick='promoteUser("+thisUser.getId()+", "+user.getId()+")'>Promote this user</button>");
		
	}
%>
</div>

<div class='col-1-3'>
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
<div class="col-1-3">
<h2>History</h2>
</div>

<div class="col-1-3">
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
<div class='footer'>Quizzard 2013.</div>
</body>
</html>