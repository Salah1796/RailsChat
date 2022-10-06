class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.bigint :Number
      t.text :Body

      t.timestamps
    end
  end
end
