class Group < ActiveRecord::Base
  has_many :groups_users, class_name: "Groups_users", dependent: :delete_all
  has_many :users, through: :groups_users
  validates :name, presence: true
  accepts_nested_attributes_for :users, allow_destroy: true
end
