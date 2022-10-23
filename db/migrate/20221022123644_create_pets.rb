class CreatePets < ActiveRecord::Migration[6.1]
  def change
    create_table :pets do |t|
      t.integer :customer_id, null: false, default: ""
      t.integer :group_id, null: false, default: ""
      t.string :pet_name, null: false, default: ""
      t.string :pet_introduction, null: false, default: ""
      t.integer :gender, null: false, default: ""
      t.integer :age, null: false, default: ""
      t.date :birthday, null: false, default: ""

      t.timestamps
    end
  end
end
