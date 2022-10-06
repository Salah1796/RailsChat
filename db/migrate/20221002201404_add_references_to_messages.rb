class AddReferencesToMessages < ActiveRecord::Migration[5.0]
  def change
    add_reference :messages, :chat, foreign_key: true , :null => false ,  index: true
  end
end
