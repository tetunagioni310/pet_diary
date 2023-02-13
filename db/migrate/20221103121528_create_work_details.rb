# frozen_string_literal: true

class CreateWorkDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :work_details do |t|
      t.integer :item_id, null: false
      t.integer :work_id, null: false
      t.integer :amount_used, null: false

      t.timestamps
    end
  end
end
