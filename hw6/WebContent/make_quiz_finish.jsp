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
<title>Quizzard - Quiz Generator - Finished</title>

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
</head>
<body>
<div class='header-wrapper'>
<div class="header"><img src='wizard_hat.png' width='30px' /><a href='index.jsp'>QUIZZARD</a>

	<ul class='menu'>
		<li><a href = "make_quiz.jsp">Make a quiz</a></li>
		<li><% out.println("<a href='profile.jsp?id="+user.getId()+"'>My public profile</a>"); %></li>
		<li><% out.println("<a href='inbox.jsp'>My inbox</a>"); %></li>
		<li><% out.println("<a href='history.jsp'>My performance history</a>"); %></li>
		<li><a href="logout.jsp">Logout</a></li>
	</ul>
	
</div>
</div>

<div class='subheader-wrapper'>
<div class='subheader'>

<div id='subheader-username'><%= user.getUsername() %></div>

<div id='search'>
	<form action="search.jsp" method="GET">
		<input type="text" name="query" />
		<input type="submit" value="Search" />
	</form>
</div>

</div>
</div>

<div class='content-wrapper'>
<div class='content'>

<%
	Quiz quiz = (Quiz)session.getAttribute("quiz");
	if(quiz == null) {
		out.println("Your session has expired.");
		return;
	}
	
	//set user id
	quiz.setUser_id(user.getId());
	//set max score
	quiz.setMax_score(quiz.getQuestions().size());
	
	QuizManager quizManager = new QuizManager(request, quiz);
	quizManager.addQuizToDataBase();
	
	for(Question question : quiz.getQuestions()) {
		if(question.getQuestionType() == 1) {
			QuestionResponseQuestion newQuestion = (QuestionResponseQuestion)question;
			quizManager.addQuestionResponseToDataBase(newQuestion.getQuestionString(), newQuestion.getAnswer());
		}
		else if(question.getQuestionType() == 2) {
			FillInTheBlankQuestion newQuestion = (FillInTheBlankQuestion)question;
			quizManager.addFillInTheBlankToDataBase(newQuestion.getFrontString(), 
													newQuestion.getBackString(), newQuestion.getAnswer());
		}
		else if(question.getQuestionType() == 3) {
			MultipleChoiceQuestion newQuestion = (MultipleChoiceQuestion)question;
			quizManager.addMultipleChoiceToDataBase(newQuestion.getQuestionString(), newQuestion.getChoices(), newQuestion.getAnswer());
		}
		else if(question.getQuestionType() == 4) {
			PictureResponseQuestion newQuestion = (PictureResponseQuestion)question;
			quizManager.addPictureResponseToDataBase(newQuestion.getFileName(), newQuestion.getQuestionString(), newQuestion.getAnswer());
		}
	} 
	quiz.setQuiz_id(quizManager.getQuizId());
	session.setAttribute("quiz", null);
	
	//category, tags
	new CatTagManager();
	CatTagManager.categorizeQuiz(quiz.getQuiz_id(), quiz.getCategory());
	CatTagManager.addStringOfTagsToQuiz(quiz.getQuiz_id(), quiz.getTags());
%>

<h3>You've created your quiz successfully!</h3>


<h4><a href='quiz_summary_page.jsp?quiz_id=<%= quiz.getQuiz_id() %>'>Check it out</a></h4>

</div><!-- end content -->
</div>

<div class='footer'><div class="pad">Quizzard 2013.</div></div>
</body>
</html>