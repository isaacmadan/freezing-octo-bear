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
<title>Quiz Result</title>
</head>
<body>
<p>
Congrats, you have finished the quiz!
</p>
<p>
Your results:
<br>
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
Score: <%=score%>/<%=maxScore %>
</p>
<br>
<%
QuizResult.addResult(user.getId(), Integer.parseInt(request.getParameter("quiz_id")), 
		score, maxScore, dur);
%>
<a href = "index.jsp">Back to Home</a>
</body>
</html>