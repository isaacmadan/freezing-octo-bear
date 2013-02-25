<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="site.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome to freezing-octo-bear!</title>
</head>
<body>

<%
	User user = (User)session.getAttribute("user");
	if(user != null) {
		out.println("<h1>" + user.getUsername()+"'s Dashboard</h1>");
		Cookie cookie = new Cookie("freezing-octo-bear",user.getUsername());
		cookie.setMaxAge(60*60*72); //72 hours
		response.addCookie(cookie);
	}
	else {
		RequestDispatcher dispatch = request.getRequestDispatcher("index.jsp");
		dispatch.forward(request, response);
	}
%>

<div><h3>Admin News</h3></div><hr>
<div><h3>Popular Quizzes</h3></div>

<hr>
<div><h3>Recently Created Quizzes</h3></div><hr>
<div><h3>My Recent Quiz Taking Activities</h3></div>

<table border="1">
<tr><th>Date</th><th>Quiz name</th><th>Score</th><th>Duration</th><th>You suck?</th></tr>
<%
	QuizResult quizResult = new QuizResult();
	ArrayList<Result> results = QuizResult.getUserPerformances(user.getId(), "BY_DATE");	
	for(Result result : results) {
		out.println("<tr><td>"+result.timeStamp+"</td><td>"+result.quizId+"</td><td>"
					+result.pointsScored+"/"+result.maxPossiblePoints+"</td><td>"
					+result.durationOfQuiz+"</td><td>yep</td></tr>");
	}
	if(results.size() == 0) {
		out.println("No quiz results");
	}
%>
</table><hr>

<div><h3>My Recent Quiz Creating Activities</h3></div>
<table border="1">
<tr><th>Date</th><th>Quiz name</th><th>Quiz Description</th></tr>
<%
	QuizManager manager = new QuizManager();
	ArrayList<Quiz> quizzes = manager.getQuizzesByUserId(user.getId());	
	for(Quiz quiz : quizzes) {
		out.println("<tr><td>"+quiz.getCreated_timestamp()+"</td><td>"+quiz.getTitle()+"</td><td>"+quiz.getDescription()+"</td><td></tr>");
	}
	if(results.size() == 0) {
		out.println("No quiz results");
	}
%>
</table><hr>

<div><h3>Achievements</h3></div><hr>
<div><h3>Messages</h3></div><hr>
<div><h3>Recent Friends' Activities</h3></div><hr>
<a href = "make_quiz.jsp">Make a Quiz</a><br />
<% out.println("<a href='profile.jsp?id="+user.getId()+"'>My profile</a><br />"); %>
<% out.println("<a href='inbox.jsp'>My inbox</a><br />"); %>
<a href="logout.jsp">Logout</a>
</body>
</html>