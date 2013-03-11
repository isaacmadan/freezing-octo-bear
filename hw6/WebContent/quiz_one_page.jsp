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
	%>
<html>
<head>
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

<title><%=thisQuiz.getTitle()%></title>
</head>
<body>
	<h1><%=thisQuiz.getTitle()%></h1>
	<p><%=thisQuiz.getDescription()%></p>
	
	<form action="quiz_one_page.jsp" method="POST">
	<% 
	ArrayList<Integer> randomIndex = (ArrayList<Integer>)session.getAttribute("randomIndex");
	if(request.getParameter("question_num") != null) {
		score = Integer.parseInt(request.getParameter("score"));
		int i = Integer.parseInt(request.getParameter("question_num"));
		
		//out.println("Random index is: " + randomIndex + "<br>");
		int type = questions.get(i).getQuestionType();
		if(type == 1) {
			out.println("Question " + Integer.toString(i+1) + " : " + ((QuestionResponseQuestion)questions.get(randomIndex.get(i))).getQuestionString() + "</br>");
			out.println("Answer: <input type = \"text\" name = \"answer_" + Integer.toString(i) + "\" id = \"answer_" + Integer.toString(i) + "\">");
			out.println("</br>");
		}
		else if(type == 2) {
			out.println("Question " + Integer.toString(i+1) + " : " + ((FillInTheBlankQuestion)questions.get(randomIndex.get(i))).getFrontString() + 
					"______" + ((FillInTheBlankQuestion)questions.get(randomIndex.get(i))).getBackString() + "</br>");
			out.println("Answer: <input type = \"text\" name = \"answer_" + Integer.toString(i) + "\" id = \"answer_" + Integer.toString(i) + "\">");
			out.println("</br>");
		}
		else if(type == 3) {
			out.println("Question " + Integer.toString(i+1) + " : " + ((MultipleChoiceQuestion)questions.get(randomIndex.get(i))).getQuestionString() + "</br>");
			for(int j = 0; j < ((MultipleChoiceQuestion)questions.get(i)).getChoices().size(); j++)
				out.println("<input type = \"radio\" name = \"answer_" + Integer.toString(i) + "\" id = \"answer_" + Integer.toString(i)
				+ "\" value = \"" + ((MultipleChoiceQuestion)questions.get(randomIndex.get(i))).getChoices().get(j).getChoiceString() + "\">" +
						((MultipleChoiceQuestion)questions.get(randomIndex.get(i))).getChoices().get(j).getChoiceString() + "<br />");
		}
		else {
			out.println("Question " + Integer.toString(i+1) + " : " + ((PictureResponseQuestion)questions.get(randomIndex.get(i))).getFileName() + "</br>");
			out.println("Answer: <input type = \"text\" name = \"answer_" + Integer.toString(i) + "\" id = \"answer_" + Integer.toString(i) + "\">");
			out.println("</br>");
		}	
		
		if(i + 1 != questions.size())
			out.println("<input type=\"hidden\" name=\"question_num\" value=\"" + Integer.toString(i + 1) + "\" />");

		if(request.getParameter("answer_" + Integer.toString(i - 1)) != null) {
			out.println("Inputted answer to last question is: " + request.getParameter("answer_" + Integer.toString(i - 1)) + "<br>");
			out.println("Correct answer to last question is: " + answers.get(randomIndex.get(i - 1)).getAnswers() + "<br>");
		}
		if(request.getParameter("answer_" + Integer.toString(i - 1)) != null && 
				Answer.getAnswerForQuestion(questions.get(randomIndex.get(i - 1)).getQuestionId()).contains(request.getParameter("answer_" + Integer.toString(i - 1)))) {
			//score++;
			out.println(score);
		}
		out.println("<input type = \"hidden\" name =\"score\" value = \"" + Integer.toString(score) +"\" >");
	}
	else {
		if(request.getParameter("answer_" + Integer.toString(questions.size() - 1)) != null && 
				Answer.getAnswerForQuestion(questions.get(randomIndex.get(questions.size() - 1)).getQuestionId()).contains(request.getParameter("answer_" + Integer.toString(questions.size() - 1)))) {
			score++;
			//out.println(score);
		}
	}
	%>
	<input type='hidden' name='start_time' value='<%=request.getParameter("start_time")%>'>
	<input type='hidden' name='quiz_id' value='<%=request.getParameter("quiz_id") %>'>
	<%
	if(request.getParameter("question_num") != null)
		out.println("<input type='submit' value='Submit Answer' />");
	%>
	</form>
	<form action=finished_quiz_one_page.jsp method="POST">
	<input type='hidden' name='quiz_id' value='<%=request.getParameter("quiz_id") %>'>
	<input type='hidden' name='max_score' value='<%=thisQuiz.getMax_score()%>'>
	<input type='hidden' name='start_time' value='<%=request.getParameter("start_time")%>'>
	<input type='hidden' name='quiz_id' value='<%=thisQuiz.getQuiz_id()%>'>
	<input type='hidden' name='score' value='<%=score%>'>
	<input type='submit' value='Submit Quiz' />
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
