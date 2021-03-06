<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<title>Quizzard - Create account failure</title>
</head>
<body id="login-background">

<div class="login">
<h1>Quizzard</h1>
<h3>Quizzard gives you the real quiz taking, creation, and sharing experience.</h3>
<div class='error'><p>Sorry, that username is taken.<br /> Please try something else.</p></div><br />

<div id='login'>
<form action="CreateUserServlet" method="POST" onsubmit="return validateForm(['username','password'])">
	<table>
		<tr><td><label>Username</label></td>
		<td><input type="text" id="username" name="username"></input></td></tr>
		<tr><td><label>Password</label></td>
		<td><input type="password" id="password" name="password"></input></td></tr>
	</table>
	<input type="submit" />
</form>
<p><a href="index.jsp">Cancel</a></p>
</div>

</body>
</html>