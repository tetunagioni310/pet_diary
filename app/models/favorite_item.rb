class FavoriteItem < ApplicationRecord
  belongs_to :customer
  has_many :favorite_item_details, dependent: :destroy
  
  validates :customer_id, presence: true

end
