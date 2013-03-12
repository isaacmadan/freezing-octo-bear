<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="site.*, java.util.*,java.sql.*,java.io.*,java.text.*"%>
<%!private Quiz thisQuiz;
	private User taker;
	private ArrayList<Question> questions;
	private ArrayList<Answer> answers;
	private int seed;
	%>

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

<title><%=thisQuiz.getTitle()%></title>
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
	<form action="finished_quiz.jsp" method="POST">
		<%
		out.println("<input type = \"hidden\" name = \"count\" id = \"count\" value = \"" + Integer.toString(questions.size())
				+ "\">");
		if(thisQuiz.isRandom_question()) {
			randomize();
			out.println("<input type = \"hidden\" name = \"random\" value = \"" + Integer.toString(seed) + "\" />");
		}
		for(int i = 0; i < questions.size(); i++) {
			int type = questions.get(i).getQuestionType();
			if(type == 1) {
				out.println("<h3>Question " + Integer.toString(i+1) + ": </h3>" + ((QuestionResponseQuestion)questions.get(i)).getQuestionString() + "</br>");
				out.println("Answer: <input type = \"text\" name = \"answer_" + Integer.toString(i) + "\" id = \"answer_" + Integer.toString(i) + "\">");
				out.println("<br /><br />");
			}
			else if(type == 2) {
				out.println("<h3>Question " + Integer.toString(i+1) + ": </h3>" + ((FillInTheBlankQuestion)questions.get(i)).getFrontString() + 
						"______" + ((FillInTheBlankQuestion)questions.get(i)).getBackString() + "</br>");
				out.println("Answer: <input type = \"text\" name = \"answer_" + Integer.toString(i) + "\" id = \"answer_" + Integer.toString(i) + "\">");
				out.println("<br /><br />");
			}
			else if(type == 3) {
				out.println("<h3>Question " + Integer.toString(i+1) + ": </h3>" + ((MultipleChoiceQuestion)questions.get(i)).getQuestionString() + "</br>");
				for(int j = 0; j < ((MultipleChoiceQuestion)questions.get(i)).getChoices().size(); j++)
					out.println("<input type = \"radio\" name = \"answer_" + Integer.toString(i) + "\" id = \"answer_" + Integer.toString(i)
					+ "\" value = \"" + ((MultipleChoiceQuestion)questions.get(i)).getChoices().get(j).getChoiceString() + "\"> " +
							((MultipleChoiceQuestion)questions.get(i)).getChoices().get(j).getChoiceString() + "<br /><br />");
			}
			else {
				out.println("<h3>Question " + Integer.toString(i+1) + ": </h3>" + ((PictureResponseQuestion)questions.get(i)).getFileName() + "</br>");
				out.println("Answer: <input type = \"text\" name = \"answer_" + Integer.toString(i) + "\" id = \"answer_" + Integer.toString(i) + "\">");
				out.println("<br /><br />");
			}	
		}
		%>
		
		<input type ="hidden" name = "start_time" value = "<%=System.currentTimeMillis() %>" />
		<input type="hidden" name="quiz_id" value="<%=thisQuiz.getQuiz_id()%>" />
		<input type='submit' value='Submit Answers' />
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

<%!
private void randomize() {
	Random seedRandom = new Random();
	seed = seedRandom.nextInt();
	Random random = new Random(seed);
	
	for(int i = 0; i < questions.size(); i++) {
		int newIndex = i + random.nextInt(questions.size() - i);
		Question temp = questions.get(i);
		questions.set(i, questions.get(newIndex));
		questions.set(newIndex, temp);
	}
}
%>
