class CreateFavoriteItemDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_item_details do |t|
      t.integer :favorite_item_id, null: false
      t.integer :item_id, null: false
      t.integer :amount_used, null: false

      t.timestamps
    end
  end
end
