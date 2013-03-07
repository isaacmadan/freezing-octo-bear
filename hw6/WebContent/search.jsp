<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="site.*,java.util.*" %>
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

<!-- USER AUTH CODE -->
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
<!-- END -->

<h1>Search</h1>

<div id="search">
	<form action="search.jsp" method="GET">
		<input type="text" name="query" />
		<input type="submit" value="Search" />
	</form>
</div>

<div id="userResults">
<h2>Users</h2>
<table border="1">
<tr><th>Username</th></tr>
<%
	String query = request.getParameter("query");
	ArrayList<User> users = Search.searchUsers(query);
	
	for(User resUser : users) {
		out.println("<tr><td><a href='profile.jsp?id="+resUser.getId()+"'>"+resUser.getUsername()+"</a></td></tr>");
	}
	if(users.size() == 0) out.println("<tr><td>No results</td></tr>");
%>
</table>
</div>

<div id="userResults">
<h2>Quizzes</h2>
<table border="1">
<tr><th>Quiz name</th><th>Description</th></tr>
<%
	query = request.getParameter("query");
	ArrayList<Quiz> quizzes = Search.searchQuizzes(query);
	
	for(Quiz quiz : quizzes) {
		out.println("<tr><td><a href='quiz_summary_page.jsp?quiz_id="+quiz.getQuiz_id()+"'>"+quiz.getTitle()+"</a></td><td>"+quiz.getDescription()+"</td></tr>");
	}
	if(quizzes.size() == 0) out.println("<tr><td></td><td>No results</td></tr>");
%>
</table>
</div>

</body>
</html>