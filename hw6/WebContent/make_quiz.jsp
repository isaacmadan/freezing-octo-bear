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

<!-- NO TOUCH - USER AUTH CODE -->
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
<!-- END -->

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Quizzard Quiz Generator</title>
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

<%
	session.setAttribute("quiz",null);
%>

<div class='content-wrapper'>
<div class='content'>
<form action="making_quiz.jsp" method="POST" onsubmit="return validateForm(['quiz_name','quiz_description'])">
	<div id='table'>
		<div id='row'><div id='left'><label>Name of Quiz</label></div>
		<div id='right'><input type="text" id="quiz_name" name="quiz_name"></input></div></div>
		<div id='row'><div id='left'><label>Quiz Description</label></div>
		<div id='right'><textarea type="text" id="quiz_description" name="quiz_description"></textarea></div></div>
		<div id='row'><div id='left'>Categories</div>
		<div id='right'>
			<select id='category' name='category'>
				<%
					new CatTagManager();
					ArrayList<String> categories = CatTagManager.getCategories();
					for(String category : categories) {
						out.println("<option name='"+category+"' value='"+category+"'>"+category+"</option>");
					}
				%>
			</select>
		</div></div>
		<div id='row'><div id='left'>Tags</div>
		<div id='right'><input type='text' id='tags' name='tags' /></div></div>
		<div id='row'><div id='left'><label>Allow Practice Mode?</label></div>
		<div id='right'><input type = "checkbox" name = "practice_mode" id = "practice_mode">Yes (leave blank for no)</div></div>
		<div id='row'><div id='left'><label>List Questions in Random Order?</label></div>
		<div id='right'><input type = "checkbox" name = "random_question" id = "random_question">Yes (leave blank for no)</div></div>
		<div id='row'><div id='left'><label>List Questions on One Page?</label></div>
		<div id='right'><input type = "checkbox" name = "one_page" id = "one_page">Yes (leave blank for multiple pages)</div></div>
		<div id='row'><div id='left'><label>Allow Immediate Correction?</label></div>
		<div id='right'><input type = "checkbox" name = "immediate_correction" id = "immediate_correction">Yes (leave blank for no)</div></div>
	</div>
	<input type='hidden' name='user_id' value='<%= user.getId() %>' />
	<input type="submit" value = "Make Quiz" />
</form>
</div>
</div>

<div class='footer'><div class="pad">Quizzard 2013.</div></div>
</body>
</html>