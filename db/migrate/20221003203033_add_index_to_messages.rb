class AddIndexToMessages < ActiveRecord::Migration[5.0]
  def change
    add_index :messages, [:chat_id, :Number] , unique: true
    add_index :messages, :Number
  end
end
