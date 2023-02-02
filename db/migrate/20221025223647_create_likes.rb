class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.integer :customer_id, null: false
      t.integer :post_id, null: false

      t.timestamps

      t.index :customer_id
      t.index :post_id
      t.index %i[customer_id post_id], unique: true
    end
  end
end
