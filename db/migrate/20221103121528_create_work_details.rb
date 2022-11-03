class CreateWorkDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :work_details do |t|
      t.integer :item_id, null: false, default: ""
      t.integer :work_id, null: false, default: ""
      t.integer :amount_used, null: false, default: ""

      t.timestamps
    end
  end
end
