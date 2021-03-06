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
<title>Quizzard - History</title>
</head>
<body>

<%
	User user = (User)session.getAttribute("user");
	if(user != null) {
		//out.println(user.getUsername()+"'s Dashboard");
		Cookie cookie = new Cookie("freezing-octo-bear",user.getUsername());
		cookie.setMaxAge(60*60*72); //72 hours
		response.addCookie(cookie);
	}
	else {
		if(request == null || response == null) {
			return;
		}
		RequestDispatcher dispatch = request.getRequestDispatcher("index.jsp");
		dispatch.forward(request, response);
	}
%>

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
<h2>My performance history</h2>
<div id='table'>
<div id='row-td'><div id='left'>Date</div><div id='left'>Quiz name</div><div id='left'>Score</div><div id='left'>Duration</div></div>
<%
	QuizManager manager = new QuizManager();	

	ArrayList<Result> results = QuizResult.getUserPerformances(user.getId(), "BY_DATE");	
	for(Result result : results) {
		Quiz quiz = manager.getQuizByQuizId(result.quizId);
		String titleString = String.valueOf(result.quizId);
		if(quiz != null) {
			titleString = quiz.getTitle();
		}
		out.println("<div id='row'><div id='left'>"+result.dateString()+"</div><div id='right'><a href='quiz_summary_page.jsp?quiz_id="+result.quizId+"'>"
					+titleString+"</a></div><div id='right'>"+result.pointsScored+"/"+result.maxPossiblePoints+"</div><div id='right'>"
					+result.durationString()+"</div></div>");
		
	}
	if(results.size() == 0) {
		out.println("No quiz results");
	}
%>
</div>
</div><!-- end content -->
</div>

<div class='footer'><div class="pad">Quizzard 2013.</div></div>
</body>
</html>