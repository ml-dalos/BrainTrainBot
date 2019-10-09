class AddQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions, force: true do |t|
      t.integer :number, null: false
      t.string :text, null: false
      t.string :origin, null: false
      t.string :images, array: true, null: false
      t.string :answer, null: false
      t.string :comment, null: false
      t.integer :chat_id, null: false
      t.integer :message_id, null: false
      t.boolean :is_current, default: false
      t.timestamps
    end
  end
end