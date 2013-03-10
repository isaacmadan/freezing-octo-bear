<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="site.*, java.util.*,java.sql.*,java.io.*,java.text.*,java.util.concurrent.TimeUnit"%>
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
	Answer a = Answer.getAnswerForQuestion(q.getQuestionId());
	answers.add(a);
}
QuizResult result = new QuizResult();
int score = 0;
if(request.getParameter("random") != null) {
	int seed = Integer.parseInt(request.getParameter("random"));
	randomize(seed);
}


for(int i = 0; i < questions.size(); i++) {
	if(answers.get(i).contains(request.getParameter("answer_" + Integer.toString(i)))) {
		score++;
	}
}
int maxScore = quiz.getMax_score();
%>
Duration: 
<%
long start_time = Long.parseLong(request.getParameter("start_time"));
long millis = System.currentTimeMillis() - start_time;
String dur = String.format("%d min, %d sec", 
	    TimeUnit.MILLISECONDS.toMinutes(millis),
	    TimeUnit.MILLISECONDS.toSeconds(millis) - 
	    TimeUnit.MINUTES.toSeconds(TimeUnit.MILLISECONDS.toMinutes(millis))
	);
%>

Duration: <%= dur %><br>
Score: <%=score%>/<%=maxScore %>
</p>
<br>
<%
QuizResult.addResult(user.getId(), Integer.parseInt(request.getParameter("quiz_id")), 
		score, maxScore, millis);
%>
<a href = "index.jsp">Back to Home</a>
</body>
<%! 
private void randomize(int seed) {
	Random random = new Random(seed);
	for(int i = 0; i < questions.size(); i++) {
		int newIndex = i + random.nextInt(questions.size() - i);
		Question temp = questions.get(i);
		questions.set(i, questions.get(newIndex));
		questions.set(newIndex, temp);
	}
}
%>
</html>