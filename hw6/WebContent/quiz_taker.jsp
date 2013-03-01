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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<%
	setup(request, response, session, out);
%>

<title><%=thisQuiz.getTitle()%></title>
</head>
<body>
	<h1><%=thisQuiz.getTitle()%></h1>
	<p><%=thisQuiz.getDescription()%></p>



	<form action="finished_quiz.jsp" method="POST">
		<input type="hidden" name="quiz_id" value="<%=thisQuiz.getQuiz_id()%>" />
		<input type='submit' value='Submit Answers' />
	</form>

</body>
</html>
<%!


private void setup(HttpServletRequest request, HttpServletResponse response, HttpSession session, JspWriter out) {
// NO TOUCH, USER AUTH CODE
		if(session == null) {
			RequestDispatcher dispatch = request.getRequestDispatcher("index.jsp");
			try {
				dispatch.forward(request, response);
			} catch (Exception e) {
				
			}
			return;
		}
		
		User user = (User)session.getAttribute("user");
		if(user == null) {
			RequestDispatcher dispatch = request.getRequestDispatcher("unauthorized.jsp");
			try {
				dispatch.forward(request, response);
			} catch (Exception e) {	
				
			}
			return;
		}
// END
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




