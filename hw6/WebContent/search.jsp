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

<div class='header-wrapper'>
<div class="header"><img src='wizard_hat.png' width='30px' /><a href='index.jsp'>QUIZZARD</a>

	<ul class='menu'>
		<li><a href = "make_quiz.jsp">Make a quiz</a></li>
		<li><% out.println("<a href='profile.jsp?id="+user.getId()+"'>My public profile</a>"); %></li>
		<li><% out.println("<a href='inbox.jsp'>My inbox</a>"); %></li>
		<li><% out.println("<a href='history.jsp'>My performance history</a>"); %></li>
		<li><a href="logout.jsp">Logout</a></li>
	</ul>
	
</div>
</div>

<div class='subheader-wrapper'>
<div class='subheader'>

<div id='subheader-username'><%= user.getUsername() %></div>

<div id='search'>
	<form action="search.jsp" method="GET">
		<input type="text" name="query" />
		<input type="submit" value="Search" />
	</form>
</div>

</div>
</div>

<div class='content-wrapper'>
<div class='content'>
<div id="userResults" class='section-white'>
<h2>Friends</h2>
<div id='table'>
<div id='row-td'><div id='left'>Username</div></div>
<%
	String query = request.getParameter("query");
	ArrayList<User> users = Search.searchUsers(query);
	
	AccountManager manager = new AccountManager();
	HashSet<Integer> friends = manager.getFriends(user.getId()); 
	boolean areResults = false;
	for(User resUser : users) {
		if(friends.contains(resUser.getId())) {
			areResults = true;
			out.println("<div id='row'><div id='left'><a href='profile.jsp?id="+resUser.getId()+"'>"+resUser.getUsername()+"</a></div></div>");
		}	
	}
	if(!areResults) out.println("<div id='row'><div id='left'>No results</div></div>");
%>
</div>
</div>

<div id="userResults" class='section'>
<h2>Users</h2>
<div id='table'>
<div id='row-td'><div id='left'>Username</div></div>
<%
	for(User resUser : users) {
		out.println("<div id='row'><div id='left'><a href='profile.jsp?id="+resUser.getId()+"'>"+resUser.getUsername()+"</a></div></div>");
	}
	if(users.size() == 0) out.println("<div id='row'><div id='left'>No results</div></div>");
%>
</div>
</div>

<div id="userResults" class='section-white'>
<h2>Quizzes</h2>
<div id='table'>
<div id='row-td'><div id='left'>Quiz name</div><div id='left'>Description</div></div>
<%
	query = request.getParameter("query");
	ArrayList<Quiz> quizzes = Search.searchQuizzes(query);
	
	for(Quiz quiz : quizzes) {
		out.println("<div id='row'><div id='left'><a href='quiz_summary_page.jsp?quiz_id="+quiz.getQuiz_id()+"'>"+quiz.getTitle()+"</a></div><div id='right'>"+quiz.getDescription()+"</div></div>");
	}
	if(quizzes.size() == 0) out.println("<div id='row'><div id='left'></div><div id='right'>No results</div></div>");
%>
</div>
</div>

<div id="userResults" class='section'>
<h2>Tags</h2>
<div id='table'>
<div id='row-td'><div id='left'>Quiz name</div><div id='left'>Description</div></div>
<%
	query = request.getParameter("query");
	new CatTagManager();
	quizzes = CatTagManager.getQuizzesFromTag(query);
	
	for(Quiz quiz : quizzes) {
		out.println("<div id='row'><div id='left'><a href='quiz_summary_page.jsp?quiz_id="+quiz.getQuiz_id()+"'>"+quiz.getTitle()+"</a></div><div id='right'>"+quiz.getDescription()+"</div></div>");
	}
	if(quizzes.size() == 0) out.println("<div id='row'><div id='left'></div><div id='right'>No results</div></div>");
%>
</div>
</div>

</div><!-- end content -->
</div>

<div class='footer'><div class="pad">Quizzard 2013.</div></div>
</body>
</html>