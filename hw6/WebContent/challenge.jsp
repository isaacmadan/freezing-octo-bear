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
<title>Quizzard - Challenge</title>
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
<%
	String friend_id = request.getParameter("friend_id");
	String challenger_id = request.getParameter("challenger_id");
	String quiz_id = request.getParameter("quiz_id");
	
	int friendId=0;
	int challengerId=0;
	int quizId=0;
	if(friend_id != null && challenger_id != null && quiz_id != null) {
		friendId = Integer.parseInt(friend_id);
		challengerId = Integer.parseInt(challenger_id);
		quizId = Integer.parseInt(quiz_id);
	}
	else {
		out.println("Sorry, we aren't able to process your challenge request.");
		return;
	}
	
	AccountManager manager = new AccountManager();
	ArrayList<Result> userResults = QuizResult.getUserPerformanceOnQuiz(challengerId, quizId, "BY_SCORE");
	String challengerScore = "-1";
	if(userResults.size() != 0) {
		challengerScore = String.valueOf((double)userResults.get(0).pointsScored / userResults.get(0).maxPossiblePoints);
	}
	manager.sendChallenge(challengerScore, String.valueOf(quizId), String.valueOf(challengerId), String.valueOf(friendId));
	out.println("Your challenge has been sent!");
	
%>

<br /><br />
<p><a href='quiz_summary_page.jsp?quiz_id=<%= request.getParameter("quiz_id") %>'>Back to quiz</a></p>
</div>
</div>

<div class='footer'><div class="pad">Quizzard 2013.</div></div>
</body>
</html>