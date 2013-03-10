$(function() {
    $( "#accordion" ).accordion();
});

$(function() {
    $( "input[type=submit], button" )
      .button()
      .click(function( event ) {
        //event.preventDefault();
      });
  });