class Groups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.integer :id
      t.string :name, null: false
      t.timestamps
    end
  end
end
