class Work < ApplicationRecord
  belongs_to :customer
  belongs_to :pet
  has_many :work_details, dependent: :destroy

  validates :customer_id, presence: true
  validates :pet_id, presence: true
  validates :work_name, presence: true

  def self.pet_work_search(keyword, current_customer)
    Work.joins(:pet).where("work_name LIKE ? OR pet_name LIKE ?", "%#{keyword}%", "%#{keyword}%")
  end
end
