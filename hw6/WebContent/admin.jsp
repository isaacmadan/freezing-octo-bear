<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="site.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	new AdminControl();
	
	String delete_user = request.getParameter("delete_user");
	String admin_id = request.getParameter("admin_id");
	String demote_user = request.getParameter("demote_user");
	String promote_user = request.getParameter("promote_user");
	String user_id = request.getParameter("user_id");
	String text = request.getParameter("text");
	String delete_quiz = request.getParameter("delete_quiz");
	String delete_quiz_results = request.getParameter("delete_quiz_results");
	String quiz_id = request.getParameter("quiz_id");
	
	if(delete_user != null && user_id != null) {
		AdminControl.removeAccount(Integer.parseInt(user_id));
	}
	
	if(demote_user != null && user_id != null && admin_id != null) {
		AdminControl.demoteFromAdmin(Integer.parseInt(admin_id), Integer.parseInt(user_id));
	}
	
	if(promote_user != null && user_id != null && admin_id != null) {
		AdminControl.promoteToAdmin(Integer.parseInt(admin_id), Integer.parseInt(user_id));
	}
	
	if(text != null && user_id != null) {
		AdminControl.AddAnouncement(Integer.parseInt(user_id), text);
		RequestDispatcher dispatch = request.getRequestDispatcher("success.jsp");
		dispatch.forward(request, response);
	}
	
	if(delete_quiz != null && quiz_id != null) {
		AdminControl.removeQuiz(Integer.parseInt(quiz_id));
	}
	
	if(delete_quiz_results != null && quiz_id != null) {
		System.out.println("clear");
		AdminControl.clearQuizResults(Integer.parseInt(quiz_id));
	}

%>

</body>
</html>