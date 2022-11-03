class Item < ApplicationRecord
  has_many :works, dependent: :destroy
  belongs_to :customer
  has_many :use_items, dependent: :destroy
  has_many :work_details, dependent: :destroy

  validates :item_name, presence: true
  validates :amount, presence: true
end
