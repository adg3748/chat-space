class GroupsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :groups_users do |t|
      t.references :groups, null: false
      t.references :users, null: false
    end
  end
end
