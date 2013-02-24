<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="site.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	User user = (User)session.getAttribute("user");
	if(user == null) {
		RequestDispatcher dispatch = request.getRequestDispatcher("index.jsp");
		dispatch.forward(request, response);
	}
%>

<h3>My inbox</h3>

<a href="compose.jsp">Send a message</a>

<table border="1">
	<tr><th>Date</th><th>From</th><th>Message</th></tr>
	<%
		ArrayList<TextMessage> messages = Inbox.getMessagesById(user.getId());
		for(int i=0; i<messages.size(); i++) {
			out.println("<tr><td>xx</td><td>"+messages.get(i).getFromUser().getUsername()+"</td><td>"+messages.get(i).getNote()+"</td></tr>");
		}
	%>
</table>

</body>
</html>