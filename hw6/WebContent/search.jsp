<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="site.*,java.util.*" %>
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
<title>Quizzard - Search</title>
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

<div class="header"><div class="pad"><a href='index.jsp'>Quizzard</a></div></div>

<div class="nav">
	<div id="links">
	<ul>
		<li><a href = "make_quiz.jsp">Make a quiz</a></li>
		<li><% out.println("<a href='profile.jsp?id="+user.getId()+"'>My public profile</a>"); %></li>
		<li><% out.println("<a href='inbox.jsp'>My inbox</a>"); %></li>
		<li><% out.println("<a href='history.jsp'>My performance history</a>"); %></li>
		<li><a href="logout.jsp">Logout</a></li>
	</ul>
	</div>
</div>

<div class='subheader'>
<div class="pad">
<%= user.getUsername() %>
<div id='search'>
	<form action="search.jsp" method="GET">
		<input type="text" name="query" />
		<input type="submit" value="Search" />
	</form>
</div>
</div>
</div>

<div class='content'>
<div id="userResults">
<h2>Friends</h2>
<table border="1">
<tr><th>Username</th></tr>
<%
	String query = request.getParameter("query");
	ArrayList<User> users = Search.searchUsers(query);
	
	AccountManager manager = new AccountManager();
	HashSet<Integer> friends = manager.getFriends(user.getId()); 
	boolean areResults = false;
	for(User resUser : users) {
		if(friends.contains(resUser.getId())) {
			areResults = true;
			out.println("<tr><td><a href='profile.jsp?id="+resUser.getId()+"'>"+resUser.getUsername()+"</a></td></tr>");
		}	
	}
	if(!areResults) out.println("<tr><td>No results</td></tr>");
%>
</table>
</div>

<div id="userResults">
<h2>Users</h2>
<table border="1">
<tr><th>Username</th></tr>
<%
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

<div id="userResults">
<h2>Tags</h2>
<table border="1">
<tr><th>Quiz name</th><th>Description</th></tr>
<%
	query = request.getParameter("query");
	new CatTagManager();
	quizzes = CatTagManager.getQuizzesFromTag(query);
	
	for(Quiz quiz : quizzes) {
		out.println("<tr><td><a href='quiz_summary_page.jsp?quiz_id="+quiz.getQuiz_id()+"'>"+quiz.getTitle()+"</a></td><td>"+quiz.getDescription()+"</td></tr>");
	}
	if(quizzes.size() == 0) out.println("<tr><td></td><td>No results</td></tr>");
%>
</table>
</div>
</div><!-- end content -->

<div class='footer'><div class="pad">Quizzard 2013.</div></div>
</body>
</html>