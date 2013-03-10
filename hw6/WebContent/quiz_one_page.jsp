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