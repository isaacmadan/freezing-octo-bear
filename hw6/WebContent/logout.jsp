<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="site.*" %>
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

<h3>You've successfully logged out.</h3>



<%

	Cookie[] cookies = request.getCookies();
	if(cookies != null) {
		for(Cookie cookie : cookies) {
			if(cookie.getName().equals("freezing-octo-bear")) {
				System.out.println("cooke 0");
				response.setContentType("text/html");
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
		}
		User user = null;
		session.setAttribute("user", user);
	
		//RequestDispatcher dispatch = request.getRequestDispatcher("success.jsp");
		//dispatch.forward(request, response);
	}

%>

<a href="index.jsp">Login again</a>

</body>
</html>