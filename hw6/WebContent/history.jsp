<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="site.*,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>History</title>
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

<div><h3>My Performance History</h3></div>

<table border="1">
<tr><th>Date</th><th>Quiz name</th><th>Score</th><th>Duration</th></tr>
<%
	QuizManager manager = new QuizManager();	

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

</body>
</html>