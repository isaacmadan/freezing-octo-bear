<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="site.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<% /**

miscellania todo list:
	get review page down - show answers results and points

 * Make Quiz servlet should behave as follows
 * 
 * Landing page - quiz name, quiz description, 
 * 					quiz choices 
 * 
 * Start quiz making - "empty quiz - add a question!"
 * 
 * 		display types of questions - then add question button, add point value button, add possible scores
 * 		finish quiz button - takes you to 
 * 
 * quiz summarypage
 *	 allows user to review and change questions, especially picture questions, which might be awful
 
 	Relevant methods and their locations
 		addQuiz to database - quizmanager
 		generatequizservlet - displays quiz at end of making session
 		
 */
 %>

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

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Quizzard Quiz Generator</title>
</head>
<body>


<form action="making_quiz" method="POST">
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
	</fieldset>
	<input type="submit" value = "Make Quiz" />
</form>




</body>
</html>