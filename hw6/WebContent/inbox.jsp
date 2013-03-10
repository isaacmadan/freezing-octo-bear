<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="site.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="styles.css">
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.1.1.min.js"></script>
<link href='http://fonts.googleapis.com/css?family=Merriweather' rel='stylesheet' type='text/css'>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Inbox</title>
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

<div class='subheader'><%= user.getUsername() %>'s Inbox</div>

<div class='content'>
<a href="compose.jsp">Send a message</a>

<table border="1">
	<tr><th>Date</th><th>From</th><th>Message</th><th>Delete</th></tr>
	<%
		AccountManager manager = new AccountManager();
		ArrayList<TextMessage> messages = Inbox.getMessagesById(user.getId());
		out.println("<input type='hidden' name='num_messages' value='"+messages.size()+"' />");
		for(int i=0; i<messages.size(); i++) {
			User fromUser = messages.get(i).getFromUser();
			
			out.println("<tr><td>"+messages.get(i).getTimestamp()+"</td><td>"
						+"<a href='profile.jsp?id="+fromUser.getId()+"'>"
						+fromUser.getUsername()+"</a>"+"</td><td>"+messages.get(i).getNote()
						+"</td><td>"
						+"<form action='DeleteTextMessageServlet' method='POST'>"
						+"<input type='hidden' name='num_messages' value='1' />"
						+"<input type='hidden' name='delete_"+i+"' value='"
						+messages.get(i).getMessageId()+"' />"
						+"<input type='submit' value='Delete' />"
						+"</form></td></tr>");
		}
	%>
</table>

</div>
</body>
</html>