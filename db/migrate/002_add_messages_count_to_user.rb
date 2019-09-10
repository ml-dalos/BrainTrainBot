class AddMessagesCountToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :messages_count, :integer, default: 0
  end
end