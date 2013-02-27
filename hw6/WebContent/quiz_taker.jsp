<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="site.*, java.util.*,java.sql.*,java.io.*,java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<%
Quiz thisQuiz = (new QuizManager()).getQuizByQuizId(Integer.parseInt(request.getParameter("quiz_id")));
User taker = (User) session.getAttribute("user");

if (thisQuiz == null){
	out.println("There is something wrong with the quiz");
	return;
}
if (taker == null){
	out.println("There is something wrong with you");
}

/*
The things that matter 

The questions that need to be displayed
The answers that have been made
Being able to place the stuff into the database
Time taken
Time spent taking
User score
max score possible

Finished quiz page

answers will be held in an answer log that is passed around
the answer log keeps two lists, 
a list of user inputs
a list of answers


one page ves multiple pages is the hard part
*/

%>

<title><%=thisQuiz.getTitle()%></title>
</head>
<body>
<h1><%=thisQuiz.getTitle()%></h1>
<p><%=thisQuiz.getDescription()%></p>

<form action="finished_quiz.jsp" method="POST">
		<input type="hidden" name="quiz_id" value="<%=thisQuiz.getQuiz_id()%>" />
		<input type='submit' value='Submit Answers' />
	</form>

</body>
</html>