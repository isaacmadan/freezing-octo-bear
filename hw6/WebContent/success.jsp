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
<div><h3>Popular Quizzes</h3>
<table border="1">
<tr><th>Date</th><th>Quiz name</th><th>Description</th><th>Created by</th></tr>
<%
	QuizResult quizResult = new QuizResult();
	ArrayList<Quiz> popularQuizzes  = QuizResult.getPopularQuizzes(0);
	AccountManager accountManager = new AccountManager();
	
	int length = 10;
	if(popularQuizzes.size() < length) length = popularQuizzes.size();
	for(int i = 0; i < length; i++) {
		Quiz quiz = popularQuizzes.get(i);
		if(quiz == null)
			out.println("<tr><td>NULL</td><td>NULL</td><td>NULL</td><td>NULL</td></tr>");
		else
			out.println("<tr><td>"+quiz.getCreated_timestamp()+"</td><td><a href='quiz_summary_page.jsp?quiz_id="+quiz.getQuiz_id()+"'>"+quiz.getTitle()+"</a></td><td>"+quiz.getDescription()+"</td><td><a href='profile.jsp?id="+accountManager.getAccountById(String.valueOf(quiz.getUser_id())).getId()+"'>"+accountManager.getAccountById(String.valueOf(quiz.getUser_id())).getUsername()+"</a></td></tr>");
	}
%>
</table>

</div>

<hr>
<div><h3>Recently Created Quizzes</h3>
<table border="1">
<tr><th>Date</th><th>Quiz name</th><th>Description</th><th>Created by</th></tr>
<%
	QuizManager manager = new QuizManager();
	ArrayList<Quiz> recentQuizzes  = manager.getWholeQuizTableByDate();
	
	length = 10;
	if(recentQuizzes.size() < length) length = recentQuizzes.size();
	for(int i = 0; i < length; i++) {
		Quiz quiz = recentQuizzes.get(i);
		if(quiz == null)
			out.println("<tr><td>NULL</td><td>NULL</td><td>NULL</td><td>NULL</td></tr>");
		else
			out.println("<tr><td>"+quiz.getCreated_timestamp()+"</td><td><a href='quiz_summary_page.jsp?quiz_id="+quiz.getQuiz_id()+"'>"+quiz.getTitle()+"</a></td><td>"+quiz.getDescription()+"</td><td><a href='profile.jsp?id="+accountManager.getAccountById(String.valueOf(quiz.getUser_id())).getId()+"'>"+accountManager.getAccountById(String.valueOf(quiz.getUser_id())).getUsername()+"</a></td></tr>");
	}
%>

</table>
</div>
<hr>

<div><h3>My Recent Quiz Taking Activities</h3></div>

<table border="1">
<tr><th>Date</th><th>Quiz name</th><th>Score</th><th>Duration</th></tr>
<%
	ArrayList<Result> results = QuizResult.getUserPerformances(user.getId(), "BY_DATE");	
	for(Result result : results) {
		Quiz quiz = manager.getQuizByQuizId(result.quizId);
		String titleString = String.valueOf(result.quizId);
		if(quiz != null) {
			titleString = quiz.getTitle();
		}
		out.println("<tr><td>"+result.timeStamp+"</td><td><a href='quiz_summary_page.jsp?quiz_id="+result.quizId+"'>"
					+titleString+"</a></td><td>"+result.pointsScored+"/"+result.maxPossiblePoints+"</td><td>"
					+result.durationOfQuiz+"</td></tr>");
		
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
	ArrayList<Quiz> quizzes = manager.getQuizzesByUserId(user.getId());	
	for(Quiz quiz : quizzes) {
		out.println("<tr><td>"+quiz.getCreated_timestamp()+"</td><td><a href='quiz_summary_page.jsp?quiz_id="+quiz.getQuiz_id()+"'>"+quiz.getTitle()+"</a></td><td>"+quiz.getDescription()+"</td></tr>");
	}
	if(results.size() == 0) {
		out.println("No quiz results");
	}
%>
</table><hr>

<div><h3>Achievements</h3>
<%
Achievements achievements = accountManager.getAchievements(user.getId());
ArrayList<String> achievementsStrings = achievements.getStrings();
for(String achievement : achievementsStrings) {
	out.println(achievement);
}
if(achievementsStrings.size() == 0)
	out.println("No achievements");
%>
</div>
<hr>

<div><h3>Messages</h3></div><hr>
<div><h3>Recent Friends' Activities</h3></div><hr>
<a href = "make_quiz.jsp">Make a Quiz</a><br />
<% out.println("<a href='profile.jsp?id="+user.getId()+"'>My profile</a><br />"); %>
<% out.println("<a href='inbox.jsp'>My inbox</a><br />"); %>
<a href="logout.jsp">Logout</a>
</body>
</html>