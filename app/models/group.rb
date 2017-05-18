class Group < ApplicationRecord

  # validation
  validates :name, length: { in: 1..8, message: "1文字以上8文字以内で入力してください" }

  # association
  has_many :users, through: :groups_users
  has_many :groups_users, class_name: "Groups_users", dependent: :delete_all
  accepts_nested_attributes_for :users, allow_destroy: true
  has_many :messages

  # scope (scopeは使用するオブジェクトに対応したModelに定義)
  scope :sort_new, -> { order("created_at DESC") }

end
