class Post < ApplicationRecord
  belongs_to :pet
  belongs_to :customer
  
  has_one_attached :post_image
  
  validates :pet_id, presence: true
  validates :customer_id, presence: true 
  validates :post_title, presence: true
  validates :post_content, presence: true
end
