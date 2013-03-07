<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="styles.css">
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.1.1.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<h3>Sorry, your login credentials didn't work</h3>
<h4>Quiz site</h4>
<p>Please login</p>

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