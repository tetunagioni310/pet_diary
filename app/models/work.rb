class Work < ApplicationRecord
  belongs_to :customer
  belongs_to :pet
  has_many :work_details, dependent: :destroy

  validates :customer_id, presence: true
  validates :pet_id, presence: true
  validates :work_name, presence: true

  # Form で一時的に選択したペットのID
  attr_accessor :pet_ids

  def pet_names
    Pet.where(id: pet_ids).map do |pet|
      "#{pet.pet_name}#{pet.pet_gender}"
    end
  end
end
