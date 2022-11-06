class CreateWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :works do |t|
      t.integer :customer_id, null: false, default: ""
      t.integer :pet_id, null: false, default: ""
      t.string :work_name, null: false, default: ""

      t.timestamps
    end
  end
end
