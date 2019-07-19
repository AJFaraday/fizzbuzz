poll_function = function () {

  message_list = $('#messages');
  indicator = $('#indicator');
  var id = message_list.data('job_id');
  if (typeof last_message == 'undefined') {
    last_message = -1;
  }
  $.get(
    '/jobs/' + id + '/poll?last_message=' + last_message,
    function (result) {
      last_message = result.last_message;
      indicator.html('Polled messages at ' + result.time);
      $('#status').html(result.status);
      $.each(
        result.messages,
        function (index, message) {
          var item = $('<li>');
          item.html(message);
          message_list.append(item);
        }
      );
      console.log(result.status);
      if (result.status == 'pending' || result.status == 'running') {
        setTimeout(poll_function, 1000);
      }
    }
  );

};

$(document).on(
  'turbolinks:load',
  function () {
    message_list = $('#messages');
    if (message_list.length == 1) {
      poll_function();
    }
  }
);