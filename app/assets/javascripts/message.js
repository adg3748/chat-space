$(function() {

  // buildHTML関数定義
  function buildHTML(message) {
    var html =
      `<ul>
        <li>
          <div class = "user-message">
            <p class = "user-name">
              ${message.name}
            </p>
            <p class = "datetime">
              ${message.created_at}
            </p>
          </div>
          <p class = "message-body">
            ${message.content}
          </p>
        </li>
      </ul>`
    return html;
  }

  $('#new_message').on('submit', function(e) {

    e.preventDefault();
    var textField = $('#message_content');
    var message = textField.val();

    $('input[type = "submit"]').removeAttr('data-disable-with');
    $.ajax({
      type: 'POST',
      url: `/groups/${gon.group.id}/messages`,
      data: {
        message: {
          content: message
        }
      },
      dataType: 'json'
    })

    .done(function(data) {
      var html = buildHTML(data);
      $('.chat-body').append(html);
      textField.val('');
    })

    .fail(function() {
      alert('error');
    });

  });
});
