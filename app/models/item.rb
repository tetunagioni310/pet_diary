class Item < ApplicationRecord
  belongs_to :customer
  has_many :use_items, dependent: :destroy
  has_many :work_details, dependent: :destroy
  has_many :favorite_item_details, dependent: :destroy

  validates :item_name, presence: true
  validates :amount, presence: true
  validates :capacity, presence: true
  validates :total_capacity, presence: true
end
