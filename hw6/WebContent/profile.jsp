<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="site.*" %>
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

<form action="add_friend.jsp" method="POST">
	<input type="hidden" name="x_id" value="<%= thisUser.getId() %>" />
	<input type="hidden" name="y_id" value="<%= user.getId() %>" />
	<input type="submit" value="Add as friend" />
</form>

</body>
</html>