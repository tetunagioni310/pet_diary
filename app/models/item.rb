class Item < ApplicationRecord
  belongs_to :customer
  has_many :use_items, dependent: :destroy
  has_many :work_details
  has_many :favorite_item_details, dependent: :destroy

  validates :item_name, presence: true
  validates :amount, presence: true
  validates :capacity, presence: true
  validates :total_capacity, presence: true

  enum unit: { grams: 0, sheets: 1, pieces: 2}
end
