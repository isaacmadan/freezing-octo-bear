$(function() {
    $( "#accordion" ).accordion();
    $( "#announcer" ).dialog();
    $( "#announcer" ).dialog("close");
});

$(function() {
    $( "input[type=submit], button" )
      .button()
      .click(function( event ) {
      });
  });

function deleteUser(userId) {
	if(confirm("Are you sure? This cannot be undone.")) {
		$.post("admin.jsp", { delete_user: "true", user_id: userId } );
		alert("You deleted this user.");
		window.location = 'index.jsp';
	}
}

function demoteUser(adminId, userId) {
	$.post("admin.jsp", { demote_user: "true", admin_id: adminId, user_id: userId } );
	alert("You demoted this user from admin.");
	location.reload();
}

function promoteUser(adminId, userId) {
	$.post("admin.jsp", { promote_user: "true", admin_id: adminId, user_id: userId } );
	alert("You promoted this user to admin.");
	location.reload();
}

function deleteQuiz(userId) {
	if(confirm("Are you sure? This cannot be undone.")) {
		$.post("admin.jsp", { delete_user: "true", user_id: userId } );
		alert("You deleted this user.");
		window.location = 'index.jsp';
	}
}

function deleteQuiz(quizId) {
	if(confirm("Are you sure? This cannot be undone.")) {
		$.post("admin.jsp", { delete_quiz: "true", quiz_id: quizId } );
		alert("You deleted this quiz.");
		window.location = 'index.jsp';
	}
}

function deleteQuizResults(quizId) {
	if(confirm("Are you sure? This cannot be undone.")) {
		$.post("admin.jsp", { delete_quiz_results: "true", quiz_id: quizId } );
		alert("You deleted this quiz's results.");
		location.reload();
	}
}

function announcerInit() {
	$( "#announcer" ).dialog( "open" );
}

function addAnswers(num) {
	$('#answers').html("<input type='hidden' value='"+num+"' name='num_answers' />");
	for(var i = 0; i < num; i++) {
		index = i + 1;
		$('#answers').append("<input type='text' name='answer"+index+"' />");
	}
}

function addChoices(num) {
	$('#choices').html("<input type='hidden' value='"+num+"' name='num_choices' />");
	for(var i = 0; i < num; i++) {
		index = i + 1;
		$('#choices').append("<input type='text' name='choice"+index+"' />");
	}
}

function validateForm(fields) {
	for(var i = 0; i < fields.length; i++) {
		var field = $('#' + fields[i]).val();
		if(field == null || field == '') {
			alert("You've left a field blank.");
			return false;
		}
	}
}

function areYouSure() {
	if(!confirm("Are you sure?")) {
		return false;
	}
}