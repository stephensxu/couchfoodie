// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  $('.drop_down_trigger').mouseenter(function() {
    $('.drop_down_list').fadeIn(200);
  }).mouseleave(function(){
    $('.drop_down_list').fadeOut(200);
  });
});
