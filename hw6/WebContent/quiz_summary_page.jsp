<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="site.*, java.util.*,java.sql.*,java.io.*,java.text.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%!
/*NOTE TO OTHERS

When quiz_summary_page posts to a quiz page with the parameter "quiz_id"
When quiz_summary_page posts to a profile page with the parameter "id"

*/

private Quiz quiz;
	private AccountManager manager;
	private User taker;

	private ArrayList<User> resultsToUsers(ArrayList<Result> res) {
		ArrayList<User> users = new ArrayList<User>();
		for (int i = 0; i < res.size(); i++) {
			int id = res.get(i).userId;
			users.add(i,
					manager.getAccountById(String.valueOf(quiz.getUser_id())));
		}
		return users;
	}
	
	
	//TODO TEST 
	private static void listPerformers(JspWriter out, ArrayList<Result> res, ArrayList<User> users){
		for (int i = 0; i < res.size(); i++){
			Result result = res.get(i);
			int userId = result.userId;
			double score = result.pointsScored / (double) result.maxPossiblePoints;
			String score2 = Double.toString(score);
			String date = java.text.DateFormat.getDateTimeInstance().format(result.timeStamp);
			String resultPrintout = users.get(i).getUsername() + " Score: " + score2 + " Time Taken: " + date;
			try{
				out.println("<a href='profile.jsp?id="+userId+"'>"+ resultPrintout + "</a>"); 
			} catch (IOException ignored){}
		}
	}
%>

<%
	manager = new AccountManager();
	quiz = Quiz.getQuiz(Integer.parseInt(request
			.getParameter("quiz_id")));
	taker = manager.getAccountById(String.valueOf(request
			.getParameter("user_id")));

	/*Each quiz should have a summary page which includes
	 The text description of the quiz.
	 The creator of the quiz (hot linked to the creators user page).
	 A list of the user's past performance on this specific quiz.  Consider allowing the 
	 user to order this by date, by percent correct, and by amount of time the quiz took.
	 A list of the highest performers of all time.
	 A list of top performers in the last day.
	 1
	 A list showing the performance of recent test takers (both good and bad).
	 Summary statistics on how well all users have performed on the quiz.
	 A way to initiate taking the quiz.
	 */
%>

<title><%=quiz.getTitle()%></title>
</head>
<body>
	<h1>
		<%=quiz.getTitle()%>
		Summary
	</h1>

	Quiz Writer:
	<a href="profile.jsp?id=" <%=quiz.getUser_id()%>> <%=manager.getAccountById(String.valueOf(quiz.getUser_id()))
					.getUsername()%></a>
	<br />
 	Your past scores with this quiz:
	<%
		// List of user's past performance on specific quiz
		ArrayList<Result> results = QuizResult.getUserPerformanceOnQuiz(
				taker.getId(), quiz.getQuiz_id());
	
	
	%>
	<br />
	Best Scores of all time:
	<% 
		// List of highest performers of all time
		results = QuizResult.getBestQuizTakers(quiz.getQuiz_id(), 0);
		ArrayList<User> bestAllTime = resultsToUsers(results);
		listPerformers(out, results, bestAllTime);
	%>
	<br />
	Best Scores in the last day:
	<% 
		// List of recent best scores in the last day
		results = QuizResult.getRecentHighScores(quiz.getQuiz_id(), 0);
		ArrayList<User> bestLastDay = resultsToUsers(results);
		listPerformers(out, results, bestLastDay);
	%>
	<br />
	
	Recent Quiz Scores:
	<%
		// List of recent 
		results = QuizResult.getRecentTakers(quiz.getQuiz_id(), 0);
		ArrayList<User> lastDay = resultsToUsers(results);	
		listPerformers(out, results, lastDay);
	%>
		
	<% 
		ArrayList<Double> numStats = QuizResult.getNumericStatistics(quiz.getQuiz_id());
		results = QuizResult.getResultStatistics(quiz.getQuiz_id());
		 DecimalFormat df = new DecimalFormat("#.##");
		out.println("<p>Number of users who have taken this quiz: " + df.format(numStats.get(QuizResult.NUM_USERS)));
		out.println("</p><p>Number of times this quiz has been taken: " + df.format(numStats.get(QuizResult.NUM_TIMES)));
		out.println("</p><p>Average Percent Correct: " + df.format(numStats.get(QuizResult.AVG_PERCENT)));
		out.println("</p><p>Average time taken: "+ df.format(numStats.get(QuizResult.AVG_TIME)));
		out.println("</p><p>Number of plays since yesterday: "+ df.format(numStats.get(QuizResult.NUM_DAY_PLAYS)));
		Result rs = results.get(QuizResult.BEST_SCORE);
		String bestScore = Double.toString(rs.pointsScored/ (double) rs.maxPossiblePoints);
		String bestUser = manager.getAccountById(String.valueOf(rs.userId)).getUsername();
		out.println("</p><p>Best Score: " + bestScore + " by <a href='profile.jsp?id="+rs.userId+"'>" + bestUser + "</a>" );
		rs = results.get(QuizResult.WORST_SCORE);
		String worstScore = Double.toString(rs.pointsScored/ (double) rs.maxPossiblePoints);
		String worstUser = manager.getAccountById(String.valueOf(rs.userId)).getUsername();
		out.println("</p><p>Worst Score: " + worstScore + " by <a href='profile.jsp?id="+rs.userId+"'>" + worstUser + "</a>" );
		out.println("</p><p>");
		out.println("</p><p>");
		out.println("<p>");
	%>


</body>
</html>