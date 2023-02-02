class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :customer_id, null: false
      t.string :item_name, null: false, default: ''
      t.integer :amount, null: false, default: 0
      t.integer :unit, null: false, default: 0
      t.integer :capacity, default: 0
      t.integer :minimum_capacity, default: 0
      t.integer :total_capacity, default: 0

      t.timestamps
    end
  end
end
