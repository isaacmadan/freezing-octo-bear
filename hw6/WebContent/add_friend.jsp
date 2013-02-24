<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="site.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	String fromId = request.getParameter("x_id");
	String toId = request.getParameter("y_id");
	
	AccountManager manager = new AccountManager();
	manager.addFriend(fromId, toId);

%>

<p>You're friend request has been sent.</p>

<a href="index.jsp">Back home</a>

</body>
</html>