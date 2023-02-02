class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :group_name, null: false, default: ''
      t.timestamps
    end
  end
end
