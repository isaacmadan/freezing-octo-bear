<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="site.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="styles.css">
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.1.1.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	String fromId = request.getParameter("x_id");
	String toId = request.getParameter("y_id");
	String unfriend = request.getParameter("unfriend");
	String confirmation = request.getParameter("confirmation");
	
	AccountManager manager = new AccountManager();
	
	if(confirmation != null) {
		manager.addFriend(Integer.parseInt(fromId), Integer.parseInt(toId));
		out.println("<p>You guys are now friends!</p>");
	}
	else if(unfriend == null) {
		manager.addFriend(Integer.parseInt(fromId), Integer.parseInt(toId));
		manager.sendFriendRequest(fromId, toId);
		out.println("<p>You're friend request has been sent.</p>");
	}
	else {
		manager.removeFriend(Integer.parseInt(fromId), Integer.parseInt(toId));
		out.println("<p>You've removed this friend successfully.</p>");
	}

%>

<a href="index.jsp">Back home</a>

</body>
</html>