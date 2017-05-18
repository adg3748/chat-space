/* $(document).on~は後から追加した
DOMオブジェクトに対してもイベントハンドラを
発火できるため、以下主にそれで記述 */

// ページ表示時に発火する即時関数の定義
$(document).on('turbolinks:load', function() {

  // 検索結果をHTMLに変換する関数の定義
  function buildResults(user) {
    var html = `
      <li>
        ${user.name}
        <a href="#" class="add-btn">
          追加
        </a>
        <input type="hidden" value="${user.id}">
      </li>
    `
    return html;
  }

  // 検索結果をリセットする関数の定義
  function resetResults() {
    var ul = $('.chat-group-form__result ul')
    ul.children().remove();
  }

  // リストの挿入関数定義
  function insertList(btn,link_text,link_class,part) {
    var link = $(btn)
    var li = link.parent();
    link.text(link_text)
    link.attr('class', link_class)
    li.remove();
    $(`.chat-group-form__${part} ul`).append(li)
  }

  // 追加がクリックされたときの駆動
  $(document).on('click', '.add-btn', function(e) {
    e.preventDefault();
    insertList(this,'削除','remove-btn','member');
    $('li input[type="hidden"]').attr({ 'name': 'group[user_ids][]' })
  });

  // 削除がクリックされた時の駆動
  $(document).on('click', '.remove-btn', function(e) {
    e.preventDefault();
    insertList(this,'追加','add-btn','result');
    $('li input[type="hidden"]').removeAttr('name')
  });

  // インクリメンタルサーチ定義
  $('.chat-group-form__search input').on('keyup', function(e) {
    e.preventDefault();
    var textField = $('.chat-group-form__search input');
    var input = textField.val();
    $.ajax({
      type:        'GET',
      data:        { keyword: input },
      url:         '/groups/search',
      dataType:    'json',
    })
    .done(function(data) {
      // 検索結果のリセット
      resetResults();
      // 検索結果一覧表示
      $.each(data, function(i,datum) {
        // キーワードが空でなければ
        if(input !== "") {
          var html = buildResults(datum);
          $('.chat-group-form__result ul').append(html);
        }
      });
    })
    .fail(function() {
      console.log('error');
    });
  });

});
