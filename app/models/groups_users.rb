class Groups_users < ApplicationRecord
  belongs_to :group
  belongs_to :user
end
