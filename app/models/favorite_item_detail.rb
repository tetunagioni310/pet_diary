class FavoriteItemDetail < ApplicationRecord
  belongs_to :favorite_item
  belongs_to :item
  
  
end
