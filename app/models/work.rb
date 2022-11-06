class Work < ApplicationRecord
  belongs_to :customer
  belongs_to :pet
  has_many :work_details, dependent: :destroy
  
  validates :customer_id, presence: true
  validates :pet_id, presence: true
  validates :work_name, presence: true
end
