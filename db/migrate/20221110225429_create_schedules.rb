class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.integer :customer_id, null: false, default: ""
      t.string :schedule_title, null: false, default: ""
      t.string :schedule_content, null: false, default: ""
      t.datetime :start_time, null: false, default: ""


      t.timestamps
    end
  end
end
