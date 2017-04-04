class Groups_users < ActiveRecord::Base
  belongs_to :groups
  belongs_to :users
end
