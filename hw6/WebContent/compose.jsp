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
<title>Quizzard - Send a message</title>
</head>
<body>

<%
	if(session == null) {
		RequestDispatcher dispatch = request.getRequestDispatcher("index.jsp");
		dispatch.forward(request, response);
		return;
	}

	User user = (User)session.getAttribute("user");
	if(user == null) {
		RequestDispatcher dispatch = request.getRequestDispatcher("unauthorized.jsp");
		dispatch.forward(request, response);
		return;
	}
%>

<div class='header-wrapper'>
<div class="header"><img src='wizard_hat.png' width='30px' /><a href='index.jsp'>QUIZZARD</a>

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
	String failure = (String)request.getAttribute("send_failure");
	if(failure != null) {
		out.println("<div class='error'>There was a problem sending your message. Please try again.</div>");
	}
%>


<form action="SendTextMessageServlet" method="POST" onsubmit="return validateForm(['to_user','content'])">
	<div id='table'>
		<input type="hidden" name="from_user" value="<%= user.getUsername() %>" />
		<div id='row'>
		<div id='left'><label>To (select a friend or enter a username): </label></div>
		<div id='right'>
			<select name="friend_id" id="composeFriendSelect">
  			<option value=""></option>
  			<% 
  			AccountManager manager = new AccountManager();
  			HashSet<Integer> friends = manager.getFriends(user.getId()); 
  			for(Integer userId : friends) {
  				out.println("<option value='"+manager.getAccountById(String.valueOf(userId)).getUsername()+"'>"+manager.getAccountById(String.valueOf(userId)).getUsername()+"</option>");
  			}
  			%>
			</select><br />
			<input type="text" name="to_user" id="to_user" />
		</div>
		<input type="hidden" name="message_type" value="3" />
		</div>
		<div id='row'>
		<div id='left'><label>Message: </label></div><div id='right'><textarea name="content" rows="10" cols="20" id="content"></textarea></div>
		</div>
	</div>
	<input type="submit" />
</form>
<a href="inbox.jsp">Back to inbox</a>
</div>
</div>

<div class='footer'><div class="pad">Quizzard 2013.</div></div>

</body>
</html>