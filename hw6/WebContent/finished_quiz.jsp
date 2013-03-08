<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="site.*, java.util.*,java.sql.*,java.io.*,java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="styles.css">
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.1.1.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Quiz Result</title>
</head>
<body>
<p>
Congrats, you have finished the quiz!
</p>
<p>
Your results:
<br>
<%
Quiz quiz = (new QuizManager()).getQuizByQuizId(Integer.parseInt(request.getParameter("quiz_id")));
try {
	if (quiz == null) {
		out.println("There is something wrong with the quiz");
		return;
	}
} catch (IOException ignored) {
}
ArrayList<Question> questions;
ArrayList<Answer> answers;
quiz.populateQuiz(); // fills quiz with questions
questions = quiz.getQuestions();
answers = new ArrayList<Answer>();
for(int i = 0; i < questions.size(); i++){
	Question q = questions.get(i);
	out.println(q.getQuestionId() + "<br>");
	Answer a = Answer.getAnswerForQuestion(q.getQuestionId());
	answers.add(a);
}

int limit = Integer.parseInt(request.getParameter("count"));
int quizID = Integer.parseInt(request.getParameter("quiz_id"));
QuizResult result = new QuizResult();
int score = 0;
for(int i = 0; i < limit; i++) {
	out.println(answers.get(i).getAnswers());
	if(answers.get(i).contains(request.getParameter("answer_" + Integer.toString(i)))) {
		score++;
	}
}
int maxScore = quiz.getMax_score();
%>

<%=score%>/<%=maxScore %>


</p>
<br>
<a href = "index.jsp">Back to Home</a>
</body>
</html>