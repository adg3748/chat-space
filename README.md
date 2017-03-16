== README

#Design Tables

comments:チャット内容保存
groups:チャットグループ保存
groups_users:groupsとusersの中間テーブル
users:ユーザー情報の保存

## commentsテーブル

| Attribute  | Type |
|:-----------:|:------------:|
|id|integer|
|content|string|
|created_at|datetime|
|updated_at|datetime|
|user_id|integer|
|group_id|integer|

## groupsテーブル

| Attribute  | Type |
|:-----------:|:------------:|
|id|integer|
|name|string|
|created_at|datetime|
|updated_at|datetime|

## groups_usersテーブル

| Attribute  | Type |
|:-----------:|:------------:|
|id|integer|
|user_id|references|
|group_id|references|

## usersテーブル

| Attribute  | Type |
|:-----------:|:------------:|
|id|integer|
|email|string|
|encrypted_password|string|
|reset_password_token|string|
|reset_password_sent_at|datetime|
|remenber_created_at|datetime|
|sign_in_count|integer|
|current_sign_in_at|datetime|
|last_sign_in_at|datetime|
|current_sign_in_ip|string|
|last_sign_in_ip|string|
|created_at|datetime|
|updated_at|datetime|
|nickname|string|
