// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  console.log("photo submit is ready");
  if(!$('#photo_picture').val()) {
   $('#photo_upload_submit').prop( "disabled", true );
   $('#photo_upload_submit').css({ opacity: 0.5 });
  }

  $('input:file').on("change", function() {
    $('#photo_upload_submit').prop('disabled', false);
    $('#photo_upload_submit').css({ opacity: 1 });
  });

  $('#photo_upload_submit').on('mouseover', function() {
    console.log("submit button is hovered on");
    $('#photo_modal').fadeIn(200);
  });
});
