<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import='site.*, java.util.*' %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="styles.css">
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.1.1.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />
<link href='http://fonts.googleapis.com/css?family=Merriweather' rel='stylesheet' type='text/css'>
<script src="site.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Quizzard - Add a Question</title>

<%
	User user = (User)session.getAttribute("user");
	if(user != null) {
		//out.println(user.getUsername()+"'s Dashboard");
		Cookie cookie = new Cookie("freezing-octo-bear",user.getUsername());
		cookie.setMaxAge(60*60*72); //72 hours
		response.addCookie(cookie);
	}
	else {
		if(request == null || response == null) {
			return;
		}
		RequestDispatcher dispatch = request.getRequestDispatcher("index.jsp");
		dispatch.forward(request, response);
	}
%>
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
	<%
		Quiz quiz = (Quiz)session.getAttribute("quiz");
		if(quiz == null) {
			out.println("Sorry your session has timed out.");
			return;
		}
		
		String questionType = request.getParameter("question_type");
		// public QuestionResponseQuestion(int quizId, int pointValue, int questionType, Answer answer, String questionString) {
		if(questionType.equals("question_response")) {
			out.println("Question Response");
			out.println("<br /><input type='text' id='numAnswers' value='# answers' /><button id='addAnswer' onclick=\"addAnswers($(\'#numAnswers\').val());\">Add answers</button><br /><hr>");
			out.println("<form action='making_quiz.jsp' method='POST'>"+
						"<input type='hidden' value='question_response' name='question_type' />"+
						"Question: <input type='text' name='question_string' /><br />"+
						"Answer(s): <div id='answers'><input type='hidden' value='1' name='num_answers' /><input type='text' name='answer1' /></div>"+
						"<button>Submit</button>"+
						"</form>");
		}
		//public FillInTheBlankQuestion(int pointValue, int questionType, Answer answer, String frontString, String backString) {
		else if(questionType.equals("fill_in_the_blank")) {
			out.println("Fill in the Blank");
			out.println("<br /><input type='text' id='numAnswers' value='# answers' /><button id='addAnswer' onclick=\"addAnswers($(\'#numAnswers\').val());\">Add answers</button><br /><hr>");
			out.println("<form action='making_quiz.jsp' method='POST'>"+
					"<input type='hidden' value='fill_in_the_blank' name='question_type' />"+
					"Question: <input type='text' name='front_string' /><br />"+
					"________<input type='text' name='back_string' />.<br />"+
					"Answer(s): <div id='answers'><input type='hidden' value='1' name='num_answers' /><input type='text' name='answer1' /></div>"+
					"<button>Submit</button>"+
					"</form>");
		}
		//public MultipleChoiceQuestion(int pointValue, int questionType, Answer answer, String questionString, ArrayList<MultipleChoiceChoices> choices) {
		else if(questionType.equals("multiple_choice")) {
			out.println("Multiple Choice");
			out.println("<br /><input type='text' id='numChoices' value='# choices' /><button id='addChoice' onclick=\"addChoices($(\'#numChoices\').val());\">Add choices</button><br />");
			out.println("<br /><input type='text' id='numAnswers' value='# answers' /><button id='addAnswer' onclick=\"addAnswers($(\'#numAnswers\').val());\">Add answers</button><br /><hr>");
			out.println("<form action='making_quiz.jsp' method='POST'>"+
					"<input type='hidden' value='multiple_choice' name='question_type' />"+
					"Question: <input type='text' name='question_string' /><br />"+
					"Choice(s): <div id='choices'><input type='hidden' value='1' name='num_choices' /><input type='text' name='choice1' /></div>"+
					"Answer(s): <div id='answers'><input type='hidden' value='1' name='num_answers' /><input type='text' name='answer1' /></div>"+
					"<button>Submit</button>"+
					"</form>");
		}
		//public PictureResponseQuestion(int pointValue, int questionType, Answer answer, String fileName) {
		else if(questionType.equals("picture_response")) {
			out.println("Picture Response");
			out.println("<br /><input type='text' id='numAnswers' value='# answers' /><button id='addAnswer' onclick=\"addAnswers($(\'#numAnswers\').val());\">Add answers</button><br /><hr>");
			out.println("<form action='making_quiz.jsp' method='POST'>"+
					"<input type='hidden' value='picture_response' name='question_type' />"+
					"Question: <input type='text' name='question_string' /><br />"+
					"URL: <input type='text' name='url_string' /><br />"+
					"Answer(s): <div id='answers'><input type='hidden' value='1' name='num_answers' /><input type='text' name='answer1' /></div>"+
					"<button>Submit</button>"+
					"</form>");
		}
	%>

</div>

<div class='footer'><div class="pad">Quizzard 2013.</div></div>
</body>
</html>