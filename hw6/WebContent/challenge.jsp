<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="site.*,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	String friend_id = request.getParameter("friend_id");
	String challenger_id = request.getParameter("challenger_id");
	
	int friendId=0;
	int challengerId=0;
	if(friend_id != null) friendId = Integer.parseInt(friend_id);
	if(challenger_id != null) challengerId = Integer.parseInt(challenger_id);

	out.println(friendId + " " + challengerId);
%>

</body>
</html>