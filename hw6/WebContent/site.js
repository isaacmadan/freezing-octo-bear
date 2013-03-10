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

function announcerInit() {
	$( "#announcer" ).dialog( "open" );
}