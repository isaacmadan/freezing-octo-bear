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

</body>
</html>