<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="site.*, java.util.*"%>
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
<title>Welcome</title>
</head>
<body id="login-background">
<%
	Cookie[] cookies = request.getCookies();
	if(cookies != null) {
	for(Cookie cookie : cookies) {
		if(cookie.getName().equals("freezing-octo-bear")) {
			AccountManager manager = (AccountManager)session.getAttribute("manager");
			if(manager == null) {
				manager = new AccountManager();
				session.setAttribute("manager", manager);
			}
			User user = manager.getAccount(cookie.getValue());
			session.setAttribute("user", user);
			
			RequestDispatcher dispatch = request.getRequestDispatcher("success.jsp");
			dispatch.forward(request, response);
	}
	}
}
%>

<div class="login">
<h1>Quizzard</h1>
<h3>Quizzard gives you the real quiz taking, creation, and sharing experience.</h3>
<p>Login to enjoy:</p>

<div id ="login">
<form action="LoginServlet" method="POST">
		<table align="center">
		<tr>
		<td><label>Username</label></td>
		<td><input type="text" id="username" name="username"></input><br /></td>
		</tr>
		<tr>
		<td><label>Password</label></td>
		<td><input type="password" id="password" name="password"></input></td>
		</tr>
		</table>
	<br />
	<input type="submit" />
	<br />
</form>

<p><a href="create.jsp">Create account</a></p>
</div>
</div><!-- end container -->

</body>
</html>