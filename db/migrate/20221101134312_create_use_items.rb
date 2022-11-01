class CreateUseItems < ActiveRecord::Migration[6.1]
  def change
    create_table :use_items do |t|
      t.integer :customer_id, null: false, default: ""
      t.integer :item_id, null: false, default: ""
      t.integer :amount_used, default: ""


      t.timestamps
    end
  end
end
