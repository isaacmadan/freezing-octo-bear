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

/*
The things that matter 

The questions that need to be displayed
The answers that have been made

*/

%>

<title><%=thisQuiz.getTitle()%></title>
</head>
<body>

</body>
</html>