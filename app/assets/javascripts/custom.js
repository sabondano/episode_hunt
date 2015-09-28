$(document).on('ready page:load', function() {
  // Make new episode submission form appear/disappear.
  $("#show-episode-submission-form-icon").on("click", function() { 
    $(".episode-submission-form").fadeToggle();
  });

  // Close/hide submission form
  $("#hide-submission-form-icon").on("click", function() {
    $(".episode-submission-form").fadeToggle();
  });

  // Show episodes in submission form per podcast selected.
  $("#podcast").on('ajax:success', function(event, data, status, xhr) { 
    var episode = $('#episode');
    episode.empty();

    $.each(data, function(index, value) {
      var option = $('<option/>');
      option.attr('value', value);
      option.text(value);
      option.appendTo(episode); 
    });
  });

  // Opt-in bootstrap tooltip
  $(function () {
    $('[data-toggle="tooltip"]').tooltip()
  })
});
