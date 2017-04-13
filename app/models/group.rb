class Group < ActiveRecord::Base
  has_many :groups_users, dependent: :destroy
  has_many :users, through: :groups_users
  validates :name, presence: true
  accepts_nested_attributes_for :groups_users
end
