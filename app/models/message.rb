class Message < ApplicationRecord

  # validation
  validates :content, :user_id, :group_id, presence: true

  # association
  belongs_to :user
  belongs_to :group

  # scope (scopeは使用するオブジェクトに対応したModelに定義)
  scope :sort_ASC, -> column { order("#{column} ASC") }

end
