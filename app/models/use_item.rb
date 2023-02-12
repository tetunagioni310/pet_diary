class UseItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer
  
  validates :amount_used, presence: true
end