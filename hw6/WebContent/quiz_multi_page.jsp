<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
    <%@ page import="site.*, java.util.*,java.sql.*,java.io.*,java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%!
	private Quiz thisQuiz;
	private User taker;
	private ArrayList<Question> questions;
	private ArrayList<Answer> answers;
	private int seed;
	int score;
	int questionNum;
	%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="styles.css">
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.1.1.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />
<link href='http://fonts.googleapis.com/css?family=Merriweather' rel='stylesheet' type='text/css'>
<script src="site.js"></script>

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
<%
	setup(request, response, session, out);
%>

<title>Quizzard - <%=thisQuiz.getTitle()%></title>
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
	<h1><%=thisQuiz.getTitle()%></h1>
	<h2><%=thisQuiz.getDescription()%></h2>
	
	<form action="quiz_multi_page.jsp" method="POST">
	<% 
	ArrayList<Integer> randomIndex = (ArrayList<Integer>)session.getAttribute("randomIndex");
	if(request.getParameter("question_num") != null) {
		
		score = Integer.parseInt(request.getParameter("score"));
		int i = Integer.parseInt(request.getParameter("question_num"));
		questionNum = i;
		
		if(request.getParameter("immediate") != null) {
			if(i != questions.size())
				out.println("<input type=\"hidden\" name=\"question_num\" value=\"" + Integer.toString(i) + "\" />");
			if(i > 0 && request.getParameter("answer_" + Integer.toString(randomIndex.get(i - 1))) != null && 
					Answer.getAnswerForQuestion(questions.get(randomIndex.get(i - 1)).getQuestionId()).contains(request.getParameter("answer_" + randomIndex.get(i - 1)))) {
				score++;
				out.println("Question " + (randomIndex.get(i - 1) + 1) + ": Correct!<br>");
				out.println("Acceptable Answers: " + Answer.getAnswerForQuestion(questions.get(randomIndex.get(i - 1)).getQuestionId()).getAnswers() + "<br><br>");
				ArrayList<String> ans = (ArrayList<String>)session.getAttribute("listOfAnswers");
				ans.add(request.getParameter("answer_" + Integer.toString(randomIndex.get(i - 1))));
			}
			else {
				out.println("Question " + (randomIndex.get(i - 1) + 1) + ": Incorrect, Sorry!<br>");
				out.println("Acceptable Answers: " + Answer.getAnswerForQuestion(questions.get(randomIndex.get(i - 1)).getQuestionId()).getAnswers() + "<br><br>");
				if(request.getParameter("answer_" + Integer.toString(randomIndex.get(i - 1))) != null) {
					ArrayList<String> ans = (ArrayList<String>)session.getAttribute("listOfAnswers");
					ans.add(request.getParameter("answer_" + Integer.toString(randomIndex.get(i - 1))));
				}
			}
			out.println("<input type = \"hidden\" name =\"score\" value = \"" + Integer.toString(score) +"\" >");
		}
		
		else {
		int type = questions.get(randomIndex.get(i)).getQuestionType();
		if(type == 1) {
			out.println("<h3>Question " + Integer.toString(i+1) + ": </h3>" + ((QuestionResponseQuestion)questions.get(randomIndex.get(i))).getQuestionString() + "</br>");
			out.println("Answer: <input type = \"text\" name = \"answer_" + Integer.toString(randomIndex.get(i)) + "\" id = \"answer_" + Integer.toString(randomIndex.get(i)) + "\">");
			out.println("<br /><br />");
		}
		else if(type == 2) {
			out.println("<h3>Question " + Integer.toString(i+1) + ": </h3>" + ((FillInTheBlankQuestion)questions.get(randomIndex.get(i))).getFrontString() + 
					"______" + ((FillInTheBlankQuestion)questions.get(randomIndex.get(i))).getBackString() + "</br>");
			out.println("Answer: <input type = \"text\" name = \"answer_" + Integer.toString(randomIndex.get(i)) + "\" id = \"answer_" + Integer.toString(randomIndex.get(i)) + "\">");
			out.println("<br /><br />");
		}
		else if(type == 3) {
			out.println("<h3>Question " + Integer.toString(i+1) + ": </h3>" + ((MultipleChoiceQuestion)questions.get(randomIndex.get(i))).getQuestionString() + "</br>");
			for(int j = 0; j < ((MultipleChoiceQuestion)questions.get(randomIndex.get(i))).getChoices().size(); j++)
				out.println("<input type = \"radio\" name = \"answer_" + Integer.toString(randomIndex.get(i)) + "\" id = \"answer_" + Integer.toString(randomIndex.get(i))
				+ "\" value = \"" + ((MultipleChoiceQuestion)questions.get(randomIndex.get(i))).getChoices().get(j).getChoiceString() + "\">" +
						((MultipleChoiceQuestion)questions.get(randomIndex.get(i))).getChoices().get(j).getChoiceString() + "<br /><br />");
		}
		else {
			out.println("<h3>Question " + Integer.toString(i+1) + ": </h3>" + ((PictureResponseQuestion)questions.get(randomIndex.get(i))).getQuestionString() + "</br>");
			out.println("<img src = \"" + ((PictureResponseQuestion)questions.get(randomIndex.get(i))).getFileName() + "\" width = 200px ></br>");
			out.println("Answer: <input type = \"text\" name = \"answer_" + Integer.toString(randomIndex.get(i)) + "\" id = \"answer_" + Integer.toString(randomIndex.get(i)) + "\">");
			out.println("<br /><br />");
		}	
		
		if(i + 1 != questions.size() || thisQuiz.isImmediate_correction()) {
			out.println("<input type=\"hidden\" name=\"question_num\" value=\"" + Integer.toString(i + 1) + "\" />");
		}
		if(i > 0 && request.getParameter("answer_" + Integer.toString(randomIndex.get(i - 1))) != null) {
			//System.out.println("randomIndex is: " + Integer.toString(randomIndex.get(i - 1)));
			ArrayList<String> ans = (ArrayList<String>)session.getAttribute("listOfAnswers");
			System.out.println("last input answer is: " + request.getParameter("answer_" + Integer.toString(randomIndex.get(i - 1))));
			ans.add(request.getParameter("answer_" + Integer.toString(randomIndex.get(i - 1))));
			session.setAttribute("listOfAnswers", ans);
		}
		if(i > 0 && request.getParameter("answer_" + Integer.toString(randomIndex.get(i - 1))) != null && 
				Answer.getAnswerForQuestion(questions.get(randomIndex.get(i - 1)).getQuestionId()).contains(request.getParameter("answer_" + Integer.toString(randomIndex.get(i - 1))))) {
			score++;
		}
		out.println("<input type = \"hidden\" name =\"score\" value = \"" + Integer.toString(score) +"\" >");
		if(thisQuiz.isImmediate_correction()) 
			out.println("<input type = \"hidden\" name =\"immediate\" value = \"ON\" >");
		}
	}
	else {
		if(request.getParameter("answer_" + Integer.toString(randomIndex.get(questions.size() - 1))) != null && 
				Answer.getAnswerForQuestion(questions.get(randomIndex.get(questions.size() - 1)).getQuestionId()).contains(request.getParameter("answer_" + Integer.toString(randomIndex.get(questions.size() - 1))))) {
			score++;
		}
		ArrayList<String> ans = (ArrayList<String>)session.getAttribute("listOfAnswers");
		if(request.getParameter("answer_" + Integer.toString(randomIndex.get(questions.size() - 1))) != null)
			ans.add(request.getParameter("answer_" + Integer.toString(randomIndex.get(questions.size() - 1))));
		//System.out.println("last input answer is: " + request.getParameter("answer_" + Integer.toString(randomIndex.get(questions.size() - 1))));
		//System.out.println("all input answer: " + ans);
		session.setAttribute("listOfAnswers", ans);
	}
	%>
	<input type='hidden' name='start_time' value='<%=request.getParameter("start_time")%>'>
	<input type='hidden' name='quiz_id' value='<%=request.getParameter("quiz_id") %>'>
	<%
	if(request.getParameter("question_num") != null)
	{
		if(request.getParameter("immediate") == null)
			out.println("<input type='submit' value='Submit Answer' />");
		else
			out.println("<input type='submit' value='Next Question' />");
	}
	%>
	</form>
	
	
	<form action=finished_quiz_multi_page.jsp method="POST" onsubmit="return areYouSure()">
	<input type='hidden' name='max_score' value='<%=thisQuiz.getMax_score()%>'>
	<input type='hidden' name='start_time' value='<%=request.getParameter("start_time")%>'>
	<input type='hidden' name='quiz_id' value='<%=thisQuiz.getQuiz_id()%>'>
	<input type='hidden' name='score' value='<%=score%>'>
	<%
	if(request.getParameter("question_num") == null) {
		out.println("The Quiz is Complete!<br>");
		out.println("<input type='submit' value='Submit Quiz' />");
	}
	%>
	</form>
	
</div><!-- end content -->
		
<div class='footer'><div class="pad">Quizzard 2013.</div></div>
</body>
</html>
<%!


private void setup(HttpServletRequest request, HttpServletResponse response, HttpSession session, JspWriter out) {
		thisQuiz = (new QuizManager()).getQuizByQuizId(Integer.parseInt(request
				.getParameter("quiz_id")));
		taker = (User) session.getAttribute("user");
		
		try {
			if (thisQuiz == null) {
				out.println("There is something wrong with the quiz");
				return;
			}
			if (taker == null) {
				out.println("There is something wrong with you");
				return;
			}
		} catch (IOException ignored) {
		}
		thisQuiz.populateQuiz(); // fills quiz with questions
		questions = thisQuiz.getQuestions();
		answers = new ArrayList<Answer>();
		for(int i = 0; i < questions.size(); i++){
			Question q = questions.get(i);
			Answer a = q.getAnswer();
			answers.add(a);
		}
		
	}
%>
