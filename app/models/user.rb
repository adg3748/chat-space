class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  #validation
  validates :name, presence: true, uniqueness: true
  validates :encrypted_password, :sign_in_count, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8, too_short: "パスワードの文字数が不足しています" }

  #association
  has_many :groups_users, class_name: "Groups_users"
  has_many :groups, through: :groups_users
  has_many :messages
end
