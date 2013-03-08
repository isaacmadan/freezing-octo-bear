<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="site.*, java.util.*,java.sql.*,java.io.*,java.text.*"%>
<%!private Quiz thisQuiz;
	private User taker;
	private ArrayList<Question> questions;
	private ArrayList<Answer> answers;
	%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="styles.css">
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.1.1.min.js"></script>

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
	<h1><%=thisQuiz.getTitle()%></h1>
	<p><%=thisQuiz.getDescription()%></p>
	<form action="finished_quiz.jsp" method="POST">
		<%
		out.println("<input type = \"hidden\" name = \"count\" id = \"count\" value = \"" + Integer.toString(questions.size())
				+ "\">");
		for(int i = 0; i < questions.size(); i++) {
			int type = questions.get(i).getQuestionType();
			if(type == 1) {
				out.println("Question " + Integer.toString(i+1) + " : " + ((QuestionResponseQuestion)questions.get(i)).getQuestionString() + "</br>");
				out.println("Answer: <input type = \"text\" name = \"answer_" + Integer.toString(i) + "\" id = \"answer_" + Integer.toString(i) + "\">");
				out.println("</br>");
			}
			else if(type == 2) {
				out.println("Question " + Integer.toString(i+1) + " : " + ((FillInTheBlankQuestion)questions.get(i)).getFrontString() + 
						"______" + ((FillInTheBlankQuestion)questions.get(i)).getBackString() + "</br>");
				out.println("Answer: <input type = \"text\" name = \"answer_" + Integer.toString(i) + "\" id = \"answer_" + Integer.toString(i) + "\">");
				out.println("</br>");
			}
			else if(type == 3) {
				out.println("Question " + Integer.toString(i+1) + " : " + ((MultipleChoiceQuestion)questions.get(i)).getQuestionString() + "</br>");
				for(int j = 0; j < ((MultipleChoiceQuestion)questions.get(i)).getChoices().size(); j++)
					out.println("<input type = \"radio\" name = \"answer_" + Integer.toString(i) + "\" id = \"answer_" + Integer.toString(i)
					+ "\" value = \"" + ((MultipleChoiceQuestion)questions.get(i)).getChoices().get(j).getChoiceString() + "\">" +
							((MultipleChoiceQuestion)questions.get(i)).getChoices().get(j).getChoiceString() + "<br />");
			}
			else {
				out.println("Question " + Integer.toString(i+1) + " : " + ((PictureResponseQuestion)questions.get(i)).getFileName() + "</br>");
				out.println("Answer: <input type = \"text\" name = \"answer_" + Integer.toString(i) + "\" id = \"answer_" + Integer.toString(i) + "\">");
				out.println("</br>");
			}	
		}
		%>
		<input type ="hidden" name = "start_time" value = "<%=System.currentTimeMillis() %>" />
		<input type="hidden" name="quiz_id" value="<%=thisQuiz.getQuiz_id()%>" />
		<input type='submit' value='Submit Answers' />
	</form>

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



