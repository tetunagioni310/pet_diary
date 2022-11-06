class CreateFavoriteItemDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_item_details do |t|
      t.integer :favorite_item_id, null: false, default: ""
      t.integer :item_id, null: false, default: ""
      t.integer :amount_used, null: false, default: ""

      t.timestamps
    end
  end
end
