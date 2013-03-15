<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="site.*, java.util.*" %>
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
<title>Quizzards - Quizzes by Categories/Tags</title>

<!-- NO TOUCH - USER AUTH CODE -->
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
</head>
<body>
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
<%
	AccountManager manager = new AccountManager();

	String category = request.getParameter("category");
	String tag = request.getParameter("tag");
	
	if(category != null) {
		out.println("<h3>Category: "+category+"</h3>");
	}
	else if(tag != null) {
		out.println("<h3>Tag: "+tag+"</h3>");
	}
%>
<table>
	<tr><th>Quiz name</th><th>Quiz description</th><th>Quiz creator</td></th>
	<%
		new CatTagManager();
		if(category != null) {
			for(Quiz quiz : CatTagManager.getQuizzesFromCategory(category)) {
				out.println("<tr><td><a href='quiz_summary_page.jsp?quiz_id="+quiz.getQuiz_id()+"'>"+quiz.getTitle()+"</a></td><td>"+quiz.getDescription()+"</td><td><a href='profile.jsp?id="+quiz.getUser_id()+"'>"+manager.getAccountById(String.valueOf(quiz.getUser_id())).getUsername()+"</a></td></tr>");
			}
		}
		else if(tag != null) {
			for(Quiz quiz : CatTagManager.getQuizzesFromTag(tag)) {
				//out.println(quiz.getQuiz_id());
				//out.println(quiz.getTitle());
				//out.println(quiz.getDescription());
				//out.println(quiz.getUser_id());
				out.println("<tr><td><a href='quiz_summary_page.jsp?quiz_id="+quiz.getQuiz_id()+"'>"+quiz.getTitle()+"</a></td><td>"+quiz.getDescription()+"</td><td><a href='profile.jsp?id="+quiz.getUser_id()+"'>"+manager.getAccountById(String.valueOf(quiz.getUser_id())).getUsername()+"</a></td></tr>");
			}
		}
	%>
</table>

</div>
</div>

<div class='footer'><div class="pad">Quizzard 2013.</div></div>
</body>
</html>