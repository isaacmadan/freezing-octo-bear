$(function() {
    $( "#accordion" ).accordion();
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
	}
}

function demoteUser(adminId, userId) {
	$.post("admin.jsp", { demote_user: "true", admin_id: adminId, user_id: userId } );
	alert("You demoted this user from admin.");
}

function promoteUser(adminId, userId) {
	$.post("admin.jsp", { promote_user: "true", admin_id: adminId, user_id: userId } );
	alert("You promoted this user to admin.");
}