class Group < ApplicationRecord
  validates :name, presence: true
  has_many :groups_users, class_name: "Groups_users", dependent: :delete_all
  has_many :users, through: :groups_users
  accepts_nested_attributes_for :users, allow_destroy: true
  has_many :messages
end
