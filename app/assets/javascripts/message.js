$(document).on('turbolinks:load', function() {

  // メッセージ一覧・投稿ページで発火
  dispatcher('^/messages/\d*', function() {
    $(function() {

      function buildHTML(message) {
        var html = `
        <ul>
          <li class='message_li' data-id='${message.id}'>
            <div class='user-message'>
              <p class='user-name'>
                ${message.name}
              </p>
              <p class='datetime'>
                ${message.created_at}
              </p>
            </div>
            <p class='message-body'>
              ${message.content}<br />
              <img src='${message.image}' class='msg-img'>
            </p>
          </li>
        </ul>
      `
        return html;
      }

      // 自動更新を行う関数
      setInterval(autoLoad, 10000);
      function autoLoad() {
        var message_id = $('.message_li:last').data('id');
        $.ajax({
          url:      location.href,
          type:     'GET',
          data:     { message: { id: message_id } },
          dataType: 'json'
        })
        .done(function(data) {
          $.each(data, function(i,datum){
            if(datum != []) {
              var html = buildHTML(datum);
              $('.chat-body').append(html);
            }
          });
        })
        .fail(function() {
          console.log('不正な値です');
        });
      }

      $('#new_message').on('submit', function(e) {
        e.preventDefault(); // 同期通信の停止
        var $form     = $(this); // formの属性を全て取得してグローバル変数に代入
        var textField = $('#message_content'); // テキストフィールド取得
        var message   = textField.val(); // テキストフィールドの値を取得
        var formdata  = new FormData($('#new_message').get(0)); // formのデータをハッシュで取得
        $('input[type="submit"]').removeAttr('data-disable-with'); // 連続投稿可能に
        $.ajax({
          type:        'POST',
          data:        formdata,
          url:         $form.attr('action'), // formのaction属性に指定された属性値を取得
          dataType:    'json',
          processData: false, // クエリー文字列への自動変換停止
          contentType: false // パラメーターがURIエスケイプされるのを防止
        })
        .done(function(data) {
          // dataにはコントローラでrender :jsonの引数に指定した変数が入る
          var html = buildHTML(data); // dataを部分テンプレートに変換してhtmlに格納
          $('.chat-body').append(html); // chat-body内最後の要素の後ろにhtmlを追加
          textField.val(''); // テキストフィールドリセット
        })
        .fail(function() {
          alert('不正な値です');
        });
      });
    });
  });

  // url毎に使うjsを差し替える関数定義
  function dispatcher(path, func) {
    dispatcher.path_func = dispatcher.path_func || []
    if (func) return dispatcher.path_func.push([path, func]);
    for(var i = 0, l = dispatcher.path_func.length; i < l; ++i) { // >
        var func = dispatcher.path_func[i];
        var match = path.match(func[0]);
        match && func[1](match);
    };
  };
  dispatcher(location.pathname);

});
