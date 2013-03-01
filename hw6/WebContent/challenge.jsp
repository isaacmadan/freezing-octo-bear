<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="site.*,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	String friend_id = request.getParameter("friend_id");
	String challenger_id = request.getParameter("challenger_id");
	String quiz_id = request.getParameter("quiz_id");
	
	int friendId=0;
	int challengerId=0;
	int quizId=0;
	if(friend_id != null && challenger_id != null && quiz_id != null) {
		friendId = Integer.parseInt(friend_id);
		challengerId = Integer.parseInt(challenger_id);
		quizId = Integer.parseInt(quiz_id);
	}
	else {
		out.println("Sorry, we aren't able to process your challenge request.");
		return;
	}
	
	AccountManager manager = new AccountManager();
	ArrayList<Result> userResults = QuizResult.getUserPerformanceOnQuiz(challengerId, quizId, "BY_SCORE");
	String challengerScore = "-1";
	if(userResults.size() != 0) {
		challengerScore = String.valueOf((double)userResults.get(0).pointsScored / userResults.get(0).maxPossiblePoints);
	}
	manager.sendChallenge(challengerScore, String.valueOf(quizId), String.valueOf(challengerId), String.valueOf(friendId));
	out.println("Your challenge has been sent!");
	
%>

</body>
</html>