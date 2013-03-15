<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import='site.*, java.util.*'%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="styles.css">
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.1.1.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />
<link href='http://fonts.googleapis.com/css?family=Merriweather'
	rel='stylesheet' type='text/css'>
<script src="site.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Quizzard - Add a Question</title>

<%
	User user = (User) session.getAttribute("user");
	if (user != null) {
		//out.println(user.getUsername()+"'s Dashboard");
		Cookie cookie = new Cookie("freezing-octo-bear",
				user.getUsername());
		cookie.setMaxAge(60 * 60 * 72); //72 hours
		response.addCookie(cookie);
	} else {
		if (request == null || response == null) {
			return;
		}
		RequestDispatcher dispatch = request
				.getRequestDispatcher("index.jsp");
		dispatch.forward(request, response);
	}
%>
</head>
<body>

	<div class='header-wrapper'>
		<div class="header">
			<img src='wizard_hat.png' width='30px' /><a href='index.jsp'>QUIZZARD</a>

			<ul class='menu'>
				<li><a href="make_quiz.jsp">Make a quiz</a></li>
				<li>
					<%
						out.println("<a href='profile.jsp?id=" + user.getId()
								+ "'>My public profile</a>");
					%>
				</li>
				<li>
					<%
						out.println("<a href='inbox.jsp'>My inbox</a>");
					%>
				</li>
				<li>
					<%
						out.println("<a href='history.jsp'>My performance history</a>");
					%>
				</li>
				<li><a href="logout.jsp">Logout</a></li>
			</ul>

		</div>
	</div>

	<div class='subheader-wrapper'>
		<div class='subheader'>

			<div id='subheader-username'><%=user.getUsername()%></div>

			<div id='search'>
				<form action="search.jsp" method="GET">
					<input type="text" name="query" /> <input type="submit"
						value="Search" />
				</form>
			</div>

		</div>
	</div>

	<div class='content-wrapper'>
		<div class='content'>
			<%
				Quiz quiz = (Quiz) session.getAttribute("quiz");
				if (quiz == null) {
					out.println("Sorry your session has timed out.");
					return;
				}

				String questionType = request.getParameter("question_type");
				// public QuestionResponseQuestion(int quizId, int pointValue, int questionType, Answer answer, String questionString) {
				if (questionType.equals("question_response")) {
					out.println("<div id='table'>");
					out.println("<span class='make_question_head'>Question Response</span>");
					out.println("<br /><input type='text' id='numAnswers' value='# of valid answers' /><button id='addAnswer' onclick=\"addAnswers($(\'#numAnswers\').val());\">Allow Multiple answers</button><br />");
					out.println("<br /><form action='making_quiz.jsp' method='POST'>"
							+ "<input type='hidden' value='question_response' name='question_type' />"
							+ "<div id='row'><div id='left'>Question? </div><div id='right'><input type='text' name='question_string' /></div></div>"
							//+ "<div id='row'><div id='left'>Answer(s)? </div><div id='right'><div id='answers'><input type='hidden' value='1' name='num_answers' /><input type='text' name='answer1' /></div></div></div>"
									+ "Answer(s)? <div id='answers'><input type='hidden' value='1' name='num_answers' /><input type='text' name='answer1' /></div>"
							+ "<button>Add Question</button>" + "</form>");
					out.println("</div>");
				}
				//public FillInTheBlankQuestion(int pointValue, int questionType, Answer answer, String frontString, String backString) {
				else if (questionType.equals("fill_in_the_blank")) {
					out.println("<div id='table'>");
					out.println("<span class='make_question_head'>Fill in the Blank</span>");
					out.println("<br /><input type='text' id='numAnswers' value='# of valid answers' /><button id='addAnswer' onclick=\"addAnswers($(\'#numAnswers\').val());\">Allow Multiple answers</button><br />");
					out.println("<form action='making_quiz.jsp' method='POST'>"
							+ "<input type='hidden' value='fill_in_the_blank' name='question_type' />"
							+ "<div id='row'><div id='left'>Question: </div><div id='right'> <input type='text' name='front_string' /></div>"
							+ "<div id='right'>____</div><div id='right'><input type='text' name='back_string' /></div></div>"
							+ "<div id='row'><div id='left'>Answer(s)? </div><div id='right'><div id='answers'><input type='hidden' value='1' name='num_answers' /><input type='text' name='answer1' /></div></div></div>"
							+ "<button>Add Question</button>" + "</form>");
					out.println("</div>");
				}
				//public MultipleChoiceQuestion(int pointValue, int questionType, Answer answer, String questionString, ArrayList<MultipleChoiceChoices> choices) {
				else if (questionType.equals("multiple_choice")) {
					out.println("<div id='table'>");
					out.println("<span class='make_question_head'>Multiple Choice</span>");
					out.println("<br /><input type='text' id='numChoices' value='# choices' /><button id='addChoice' onclick=\"addChoices($(\'#numChoices\').val());\">Add choices</button>");
					out.println("<input type='text' id='numAnswers' value='# of valid answers' /><button id='addAnswer' onclick=\"addAnswers($(\'#numAnswers\').val());\">Allow Multiple answers</button><br />");
					out.println("<br /><form action='making_quiz.jsp' method='POST'>"
							+ "<input type='hidden' value='multiple_choice' name='question_type' />"
							+ "<div id='row'><div id='left'>Question: </div><div id='right'><input type='text' name='question_string' /></div></div>"
							+ "<div id='row'><div id='left'>Choice(s): </div><div id='right'><div id='choices'><input type='hidden' value='1' name='num_choices' /><input type='text' name='choice1' /></div></div></div>"
							+ "<div id='row'><div id='left'>Answer(s): </div><div id='right'><div id='answers'><input type='hidden' value='1' name='num_answers' /><input type='text' name='answer1' /></div></div></div>"
							+ "<br /><button>Add Question</button>" + "</form>");
					out.println("</div>");
				}
				//public PictureResponseQuestion(int pointValue, int questionType, Answer answer, String fileName) {
				else if (questionType.equals("picture_response")) {
					out.println("<div id='table'>");
					out.println("<span class='make_question_head'>Picture Response</span>");
					out.println("<br /><input type='text' id='numAnswers' value='# of valid answers' /><button id='addAnswer' onclick=\"addAnswers($(\'#numAnswers\').val());\">Allow Multiple answers</button><br />");
					out.println("<form action='making_quiz.jsp' method='POST'>"
							+ "<input type='hidden' value='picture_response' name='question_type' />"
							+ "<div id='row'><div id='left'>Question: </div><div id='right'><input type='text' name='question_string' /></div></div>"
							+ "<div id='row'><div id='left'>URL: </div><div id='right'><input type='text' name='url_string' /></div></div>"
							+ "<div id='row'><div id='left'>Answer(s): </div><div id='right'><div id='answers'><input type='hidden' value='1' name='num_answers' /><input type='text' name='answer1' /></div></div></div>"
							+ "<button>Add Question</button>" + "</form>");
					out.println("</div>");
				}
			%>

		</div>
	</div>

	<div class='footer'>
		<div class="pad">Quizzard 2013.</div>
	</div>
</body>
</html>