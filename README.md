== README

# Design Tables

## Associations

comments belongs_to :groups
comments belongs_to :users
groups has_many :comments
users has_many :comments
groups has_many users, through :groups_users
users has_many groups, through :groups_users

## commentsテーブル

| Attribute  | Type |
|:-----------:|:------------:|
|id|integer|
|content|string|
|created_at|datetime|
|updated_at|datetime|
|user_id|references|
|group_id|references|

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
