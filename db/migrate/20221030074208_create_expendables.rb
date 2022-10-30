class CreateExpendables < ActiveRecord::Migration[6.1]
  def change
    create_table :expendables do |t|
      t.integer :pet_id, null: false, default: ""
      t.string :expendable_name, null: false, default: ""
      t.integer :amount, null: false, default: ""
      t.integer :capacity, null: false, default: ""
      t.integer :total_capacity, null: false, default: ""

      t.timestamps
    end
  end
end
