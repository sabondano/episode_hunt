$(document).on('ready page:load', function() {
  // Make new episode submission form appear/disappear.
  $("#submit-episode").on("click", function() { 
    $(".episode-submission-form").fadeToggle();
  });
});
