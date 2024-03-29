# frozen_string_literal: true

class CreateFavoriteItems < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_items do |t|
      t.integer :customer_id, null: false
      t.string :favorite_item_name, default: ""

      t.timestamps
    end
  end
end
