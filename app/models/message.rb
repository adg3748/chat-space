class Message < ApplicationRecord

  # validation
  validates :content, :user_id, :group_id, presence: true

  # association
  belongs_to :user
  belongs_to :group
end
