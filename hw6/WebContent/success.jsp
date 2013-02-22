<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="site.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome to freezing-octo-bear!</title>
</head>
<body>

<%
	User user = (User)session.getAttribute("user");
	out.println("Hi " + user.getUsername()+"!<br /><br />");
	Cookie cookie = new Cookie("freezing-octo-bear",user.getUsername());
	cookie.setMaxAge(60*60*72); //72 hours
	response.addCookie(cookie);
%>
<div>Admin News</div><hr>
<div>Popular Quizzes</div><hr>
<div>Recently Created Quizzes</div><hr>
<div>Recent Quiz Taking Activities</div><hr>
<div>Recent Quiz Creating Activities</div><hr>
<div>Achievements</div><hr>
<div>Messages</div><hr>
<div>Recent Friends' Activities</div><hr>
<a href = "make_quiz.jsp">Make a Quiz</a>
</body>
</html>