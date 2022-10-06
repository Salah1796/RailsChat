class AddIndexToChats < ActiveRecord::Migration[5.0]
  def change
    add_index :chats, [:application_id, :Number] , unique: true
    add_index :chats, :Number
  end
end
