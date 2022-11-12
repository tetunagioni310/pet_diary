class Schedule < ApplicationRecord
  belongs_to :customer
  
  validates :customer_id, presence: true
  validates :schedule_title, presence: true
  validates :schedule_content, presence: true
  validates :start_time, presence: true
  
end
