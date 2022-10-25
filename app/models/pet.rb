class Pet < ApplicationRecord
  belongs_to :customer
  belongs_to :group
  has_many :posts, dependent: :destroy
  
  validates :pet_name, presence: true
  validates :pet_introduction, presence: true
  validates :gender, presence: true
  validates :age, presence: true
  
  has_one_attached :pet_image
  
  enum gender: { ♂: 1, ♀: 2 }
end