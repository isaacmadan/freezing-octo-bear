<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="site.*, java.util.*" %>
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
<title>Quizzard - Quiz Generator</title>

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

<!-- Declare variables and methods-->

<%!
boolean starting;
int numQuestions;
%>

<!--  -->

<!-- Initialize variables etc -->

<% 

%>

<title>Quizzard Quiz Generator</title>
<!-- END -->

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
		String quizName = request.getParameter("quiz_name");
		String quizDescription = request.getParameter("quiz_description"); 
		String practiceMode = request.getParameter("practice_mode");
		String randomMode = request.getParameter("random_question");
		String onePageMode = request.getParameter("one_page");
		String immediateCorrectionMode = request.getParameter("immediate_correction");
		String userId = request.getParameter("user_id");
		String category = request.getParameter("category");
		String tags = request.getParameter("tags");
	
		boolean practice = false;
		if(practiceMode != null) practice = true;
		boolean random = false;
		if(randomMode != null) random = true;
		boolean onepage = false;
		if(onePageMode != null) onepage = true;
		boolean immediate = false;
		if(immediateCorrectionMode != null) immediate = true;
		
		quiz = new Quiz(Integer.parseInt(userId), practice, quizDescription, quizName, random, onepage, immediate, category, tags);
		session.setAttribute("quiz", quiz);
	}
%>

<div>
<form method='POST' action='add_question.jsp'>
	<select name='question_type'>
		<option value='question_response'>Question response</option>
		<option value='fill_in_the_blank'>Fill in the blank</option>
		<option value='multiple_choice'>Multiple choice</option>
		<option value='picture_response'>Picture response</option>
	</select>
	<input type='submit' value='Add a question' />
</form>

<form method='POST' action='make_quiz_finish.jsp'>
	<input type='submit' value='Finish' />
</form>
</div>

<%
		String questionType = request.getParameter("question_type");
		if(questionType == null) return;
		
		String QUESTION_TYPES[] = {"", "Question Response", "Fill in the Blank", "Multiple Choice", "Picture Response" };
		
		// public QuestionResponseQuestion(int quizId, int pointValue, int questionType, Answer answer, String questionString) {
		if(questionType.equals("question_response")) {
			String questionString = request.getParameter("question_string");
			Integer numAnswers = Integer.parseInt(request.getParameter("num_answers"));
			Answer answers = new Answer();
			for(int i = 1; i <= numAnswers; i++) {
				answers.addAnswer(request.getParameter("answer"+i));
			}
			out.println("<br /><div class='success'>Question Response created</div><br />");
			QuestionResponseQuestion question = new QuestionResponseQuestion(0, 1, 1, answers, questionString);
			quiz.addQuestion(question);
		}
		//public FillInTheBlankQuestion(int pointValue, int questionType, Answer answer, String frontString, String backString) {
		else if(questionType.equals("fill_in_the_blank")) {
			String frontString = request.getParameter("front_string");
			String backString = request.getParameter("back_string");
			Integer numAnswers = Integer.parseInt(request.getParameter("num_answers"));
			Answer answers = new Answer();
			for(int i = 1; i <= numAnswers; i++) {
				answers.addAnswer(request.getParameter("answer"+i));
			}
			
			out.println("<br /><div class='success'>Fill in the Blank created</div><br />");
			FillInTheBlankQuestion question = new FillInTheBlankQuestion(1, 2, answers, frontString, backString);
			quiz.addQuestion(question);
		}
		//public MultipleChoiceQuestion(int pointValue, int questionType, Answer answer, String questionString, ArrayList<MultipleChoiceChoices> choices) {
		else if(questionType.equals("multiple_choice")) {
			String questionString = request.getParameter("question_string");
			Integer numChoices = Integer.parseInt(request.getParameter("num_choices"));
			ArrayList<MultipleChoiceChoices> choices = new ArrayList<MultipleChoiceChoices>();
			for(int i = 1; i <= numChoices; i++) {
				choices.add(new MultipleChoiceChoices(request.getParameter("choice"+i)));
			}
			Integer numAnswers = Integer.parseInt(request.getParameter("num_answers"));
			Answer answers = new Answer();
			for(int i = 1; i <= numAnswers; i++) {
				answers.addAnswer(request.getParameter("answer"+i));
			}
			
			out.println("<br /><div class='success'>Multiple Choice created</div><br />");
			MultipleChoiceQuestion question = new MultipleChoiceQuestion(1, 3, answers, questionString, choices);
			quiz.addQuestion(question);
		}
		//public PictureResponseQuestion(int pointValue, int questionType, Answer answer, String fileName) {
		else if(questionType.equals("picture_response")) {
			String questionString = request.getParameter("question_string");
			String urlString = request.getParameter("url_string");
			Integer numAnswers = Integer.parseInt(request.getParameter("num_answers"));
			Answer answers = new Answer();
			for(int i = 1; i <= numAnswers; i++) {
				answers.addAnswer(request.getParameter("answer"+i));
			}
			
			out.println("<br /><div class='success'>Picture Response created</div><br />");
			//PictureResponseQuestion question = new PictureResponseQuestion(1, 4, answers, questionString);
			PictureResponseQuestion question = new PictureResponseQuestion(1, 4, answers, urlString);
			quiz.addQuestion(question);
		}
%>

<div>
<%
	ArrayList<Question> questions = quiz.getQuestions();
	for(Question question : questions) {
		int thisQuestionType = question.getQuestionType();
		out.println("<strong>Question: "+QUESTION_TYPES[thisQuestionType]+"</strong><br />");
		if(thisQuestionType == 1) {
			QuestionResponseQuestion newQuestion = (QuestionResponseQuestion)question;
			out.println(newQuestion.getQuestionString() + "<br />");
			out.println("<br />Answers: <br />");
			Answer newAnswers = newQuestion.getAnswer();
			for(String newAnswer : newAnswers.getAnswers()) {
				out.println(newAnswer + "<br />");
			}
		}
		if(thisQuestionType == 2) {
			FillInTheBlankQuestion newQuestion = (FillInTheBlankQuestion)question;
			out.println(newQuestion.getFrontString() + " ____________ " + newQuestion.getBackString() + ".<br />");
			out.println("<br />Answers: <br />");
			Answer newAnswers = newQuestion.getAnswer();
			for(String newAnswer : newAnswers.getAnswers()) {
				out.println(newAnswer + "<br />");
			}
		}
		if(thisQuestionType == 3) {
			MultipleChoiceQuestion newQuestion = (MultipleChoiceQuestion)question;
			out.println(newQuestion.getQuestionString() + "<br />");
			out.println("<br />Choices: <br />");
			ArrayList<MultipleChoiceChoices> newChoices = newQuestion.getChoices();
			for(MultipleChoiceChoices choice : newChoices) {
				out.println(choice.getChoiceString() + "<br />");
			}
			out.println("<br />Answers: <br />");
			Answer newAnswers = newQuestion.getAnswer();
			for(String newAnswer : newAnswers.getAnswers()) {
				out.println(newAnswer + "<br />");
			}
		}	
		if(thisQuestionType == 4) {
			PictureResponseQuestion newQuestion = (PictureResponseQuestion)question;
			out.println("<img src='"+newQuestion.getFileName()+"' width='200px' />");
			out.println("<br />Answers: <br />");
			Answer newAnswers = newQuestion.getAnswer();
			for(String newAnswer : newAnswers.getAnswers()) {
				out.println(newAnswer + "<br />");
			}
		}
		out.println("<hr>");
	}
%>
</div>

</div><!-- end content -->

<%
/**/


%>

<div class='footer'><div class="pad">Quizzard 2013.</div></div>
</body>
</html>