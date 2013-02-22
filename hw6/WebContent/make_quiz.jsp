<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Making a Quiz</title>
</head>
<body>
<form action="MakeQuizServlet" method="POST">
	<fieldset>
		<label>Name of Quiz</label>
		<input type="text" id="quiz_name" name="quiz_name"></input><br />
		<label>Quiz Description</label>
		<input type="text" size="100" id="quiz_description" name="quiz_description"><br />
		<label>Choose All Types of Questions and Numbers</label><br />
		&nbsp&nbsp&nbsp&nbsp<input type="checkbox" name ="question_response" id ="question_response">Question-Response<br />
		&nbsp&nbsp&nbsp&nbsp<input type="text" size = "3" id="question_response_num" name = "question_response_num">Number of Questions<br />
	</fieldset>
	<input type="submit" />
</form>
</body>
</html>