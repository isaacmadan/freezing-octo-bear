<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="site.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<h3>Welcome to freezing-octo-bear</h3>
<h4>Quiz site</h4>
<p>Please login</p>

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

<div id ="login">
<form action="LoginServlet" method="POST">
	<fieldset>
		<label>Username</label>
		<input type="text" id="username" name="username"></input><br />
		<label>Password</label>
		<input type="password" id="password" name="password"></input>
	</fieldset>
	<input type="submit" />
</form>
<a href="create.jsp">Create account</a>
</div>

</body>
</html>