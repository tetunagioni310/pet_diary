class Post < ApplicationRecord
  belongs_to :pet, dependent: :destroy
  
  has_one_attached :post_image
end
