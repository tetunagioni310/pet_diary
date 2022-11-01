class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :customer_id, null: false, default: ""
      t.string :item_name, null: false, default: ""
      t.integer :amount, null: false, default: ""
      t.integer :capacity, default: ""
      t.integer :total_capacity, default: ""

      t.timestamps
    end
  end
end
