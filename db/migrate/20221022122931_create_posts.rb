class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :customer_id, null: false
      t.integer :pet_id, null: false
      t.string :post_title, null: false, default: ""
      t.string :post_content, null: false, default: ""
      t.datetime :start_time, null: false, default: ""

      t.timestamps
    end
  end
end
