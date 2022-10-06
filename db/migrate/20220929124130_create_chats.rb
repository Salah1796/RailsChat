class CreateChats < ActiveRecord::Migration[5.0]
  def change
    create_table :chats do |t|
      t.bigint :Number
      t.bigint :messages_count

      t.timestamps
    end
  end
end
