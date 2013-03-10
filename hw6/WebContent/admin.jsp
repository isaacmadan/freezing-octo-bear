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
	String admin_user = request.getParameter("admin_user");
	String demote_user = request.getParameter("demote_user");
	String promote_user = request.getParameter("promote_user");
	String user_id = request.getParameter("user_id");
	
	if(delete_user == "true" && user_id != null) {
		AdminControl.removeAccount(Integer.parseInt(user_id));
	}
	
	if(demote_user == "true" && user_id != null && admin_user != null) {
		AdminControl.demoteFromAdmin(Integer.parseInt(admin_user), Integer.parseInt(demote_user));
	}
	
	if(promote_user == "true" && user_id != null && admin_user != null) {
		AdminControl.promoteToAdmin(Integer.parseInt(admin_user), Integer.parseInt(demote_user));
	}

%>

</body>
</html>