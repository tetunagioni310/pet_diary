# frozen_string_literal: true

class CreateUseItems < ActiveRecord::Migration[6.1]
  def change
    create_table :use_items do |t|
      t.integer :customer_id, null: false
      t.integer :item_id, null: false
      t.integer :amount_used

      t.timestamps
    end
  end
end
