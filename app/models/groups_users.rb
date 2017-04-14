class Groups_users < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
end
