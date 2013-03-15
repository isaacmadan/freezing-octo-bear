<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="site.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="styles.css">
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.1.1.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />
<link href='http://fonts.googleapis.com/css?family=Merriweather' rel='stylesheet' type='text/css'>
<script src="site.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Quizzard - Admin</title>

<%
	User user = (User)session.getAttribute("user");
	if(user != null) {
		//out.println(user.getUsername()+"'s Dashboard");
		Cookie cookie = new Cookie("freezing-octo-bear",user.getUsername());
		cookie.setMaxAge(60*60*72); //72 hours
		response.addCookie(cookie);
	}
	else {
		if(request == null || response == null) {
			return;
		}
		RequestDispatcher dispatch = request.getRequestDispatcher("index.jsp");
		dispatch.forward(request, response);
	}
%>
</head>
<body>

<div class='header-wrapper'>
<div class="header"><a href='index.jsp'>QUIZZARD</a>

	<ul class='menu'>
		<li><a href = "make_quiz.jsp">Make a quiz</a></li>
		<li><% out.println("<a href='profile.jsp?id="+user.getId()+"'>My public profile</a>"); %></li>
		<li><% out.println("<a href='inbox.jsp'>My inbox</a>"); %></li>
		<li><% out.println("<a href='history.jsp'>My performance history</a>"); %></li>
		<li><a href="logout.jsp">Logout</a></li>
	</ul>
	
</div>
</div>

<div class='subheader-wrapper'>
<div class='subheader'>

<div id='subheader-username'><%= user.getUsername() %></div>

<div id='search'>
	<form action="search.jsp" method="GET">
		<input type="text" name="query" />
		<input type="submit" value="Search" />
	</form>
</div>

</div>
</div>

<div class='content-wrapper'>
<div class='content'>
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
</div>
</div>

</body>
</html>