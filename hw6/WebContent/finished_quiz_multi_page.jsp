<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
    <%@ page import="site.*, java.util.*,java.sql.*,java.io.*,java.text.*,java.util.concurrent.TimeUnit"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%!
int score;
int maxScore;
long dur;
%>

<head>
<link rel="stylesheet" type="text/css" href="styles.css">
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.1.1.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />
<link href='http://fonts.googleapis.com/css?family=Merriweather' rel='stylesheet' type='text/css'>
<script src="site.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
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
<title>Quizzard - Finished - Quiz Result</title>
</head>
<body>
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
<h2>Congrats, you have finished the quiz!</h2>
<%
ArrayList<String> ans = (ArrayList<String>)session.getAttribute("listOfAnswers");
for(int i = 0; i < questions.size(); i++) {
	//out.println(answers.get(i).getAnswers());
	if(answers.get(i).contains(request.getParameter("answer_" + Integer.toString(i)))) {
		score++;
		out.println("Question " + (i + 1) + ": Correct!<br>");
		out.println("Acceptable Answers: " + answers.get(i).getAnswers() + "<br><br>");
	}
	else {
		out.println("Question " + (i + 1) + ": Incorrect, Sorry!<br>");
		out.println("Acceptable Answers: " + answers.get(i).getAnswers() + "<br><br>");
	}
}



%>

<h3>Your results:</h3>
<p>
<%
score = Integer.parseInt(request.getParameter("score"));
maxScore = Integer.parseInt(request.getParameter("max_score"));
dur = System.currentTimeMillis() - Long.parseLong(request.getParameter("start_time"));
String length = String.format("%d min, %d sec", 
	    TimeUnit.MILLISECONDS.toMinutes(dur),
	    TimeUnit.MILLISECONDS.toSeconds(dur) - 
	    TimeUnit.MINUTES.toSeconds(TimeUnit.MILLISECONDS.toMinutes(dur))
	);
%>
Duration: <%= length %><br>
Score: <%=score%>/<%= maxScore %>
</p>
<br>

<!-- update IAmTheGreatest Achievement -->
<%
	new QuizResult();
	ArrayList<Result> results = QuizResult.getAllTimeBest(Integer.parseInt(request.getParameter("quiz_id")), 0);
	boolean isGreatest = false;
	if(results.size() == 0) isGreatest = true;
	else if(maxScore > results.get(0).pointsScored) isGreatest = true;
	if(isGreatest) {
		AccountManager manager = new AccountManager();
		Achievements achievements = manager.getAchievements(user.getId());
		manager.updateAchievements(user.getId(), true); //add i am the greatest
	}
%>

<%
QuizResult.addResult(user.getId(), Integer.parseInt(request.getParameter("quiz_id")), 
		score, maxScore, dur);
%>
<a href = "index.jsp">Back to Home</a>
</div><!-- end content -->

<div class='footer'><div class="pad">Quizzard 2013.</div></div>
</body>
</html>