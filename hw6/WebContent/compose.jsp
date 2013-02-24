<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="site.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Send a message</title>
</head>
<body>

<%
	if(session == null) {
		RequestDispatcher dispatch = request.getRequestDispatcher("index.jsp");
		dispatch.forward(request, response);
		return;
	}

	User user = (User)session.getAttribute("user");
	if(user == null) {
		RequestDispatcher dispatch = request.getRequestDispatcher("unauthorized.jsp");
		dispatch.forward(request, response);
		return;
	}
%>

<form action="SendTextMessageServlet" method="POST">
	<fieldset>
		<input type="hidden" name="from_user" value="<%= user.getUsername() %>" />
		<label>To (username): </label><input type="text" name="to_user" /><br />
		<input type="hidden" name="message_type" value="3" />
		<label>Message: </label><textarea name="content" rows="10" cols="30"></textarea><br />
		<input type="submit" />
	</fieldset>
</form>

</body>
</html>