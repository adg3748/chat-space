class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, :encrypted_password, :sign_in_count, presence: true
  has_many :groups_users, class_name: "Groups_users"
  has_many :groups, through: :groups_users
  has_many :messages
end
