<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="site.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
	if(user != null) {
		if(thisUser != null && user.getId() == thisUser.getId()) {
			out.println("You're viewing your own profile.<br />");
		}
	}
%>

<title><%= user.getUsername() %>'s profile</title>
</head>
<body>

<h1><%= user.getUsername() %></h1>

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

<br />
<form action="add_friend.jsp" method="POST">
	<input type="hidden" name="x_id" value="<%= thisUser.getId() %>" />
	<input type="hidden" name="y_id" value="<%= user.getId() %>" />
	<% 
		if(manager.areFriends(thisUser.getId(), user.getId())) {
			out.println("<input type='hidden' name='unfriend' value='true' />");
			out.println("<input type='submit' value='Remove as friend' />");
		}
		else {
			out.println("<input type='submit' value='Add as friend' />");
		}
	%>
	
</form>

<h2>History</h2>

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

</body>
</html>