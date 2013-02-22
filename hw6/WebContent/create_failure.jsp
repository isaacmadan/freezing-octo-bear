<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<h3>Sorry, that username is taken</h3>
<h4>Quiz site</h4>
<p>Please login</p>

<div id ="login">
<form action="CreateUserServlet" method="POST">
	<fieldset>
		<label>Username</label>
		<input type="text" id="username" name="username"></input><br />
		<label>Password</label>
		<input type="password" id="password" name="password"></input>
	</fieldset>
	<input type="submit" />
</form>
</div>

</body>
</html>