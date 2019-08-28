class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, force: true do |t|
      t.integer :uid, null: false
      t.string :first_name
      t.string :last_name
      t.string :username
      t.timestamps
    end
  end
end