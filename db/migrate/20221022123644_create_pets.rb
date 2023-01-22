class CreatePets < ActiveRecord::Migration[6.1]
  def change
    create_table :pets do |t|
      t.integer :customer_id, null: false
      t.integer :group_id, null: false
      t.string :pet_kind, null: false, default: ""
      t.string :pet_name, null: false, default: ""
      t.string :pet_introduction, null: false, default: ""
      t.integer :gender, null: false
      t.date :birthday, null: false

      t.timestamps
    end
  end
end
