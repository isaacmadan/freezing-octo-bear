<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="site.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="styles.css">
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.1.1.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Making a Quiz</title>
</head>
<body>

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

<form action="MakeQuizServlet" method="POST">
	<fieldset>
		<label>Name of Quiz</label>
		<input type="text" id="quiz_name" name="quiz_name"></input><br />
		<label>Quiz Description</label>
		<input type="text" size="100" id="quiz_description" name="quiz_description"><br />
		<label>Allow Practice Mode?</label>
		<input type = "checkbox" name = "practice_mode" id = "practice_mode">Yes (leave blank for no)<br />
		<label>List Questions in Random Order?</label>
		<input type = "checkbox" name = "random_question" id = "random_question">Yes (leave blank for no)<br />
		<label>List Questions on One Page?</label>
		<input type = "checkbox" name = "one_page" id = "one_page">Yes (leave blank for multiple pages)<br />
		<label>Allow Immediate Correction?</label>
		<input type = "checkbox" name = "immediate_correction" id = "immediate_correction">Yes (leave blank for no)<br />
		<label>Choose All Types of Questions and Numbers</label><br />
		<input type="checkbox" name ="question_response" id ="question_response">Question-Response<br />
		<input type="text" size = "3" id="question_response_num" name = "question_response_num">Number of Questions<br />
		<input type="checkbox" name ="fill_in_the_blank" id ="fill_in_the_blank">Fill in the Blank<br />
		<input type="text" size = "3" id="fill_in_the_blank_num" name = "fill_in_the_blank_num">Number of Questions<br />
		<input type="checkbox" name ="multiple_choice" id ="multiple_choice">Multiple Choice<br />
		<input type="text" size = "3" id="multiple_choice_num" name = "multiple_choice_num">Number of Questions<br />
		<input type="checkbox" name ="picture_response" id ="picture_response">Picture-Response<br />
		<input type="text" size = "3" id="picture_response_num" name = "picture_response_num">Number of Questions<br />
	</fieldset>
	<input type="submit" />
</form>
</body>
</html>