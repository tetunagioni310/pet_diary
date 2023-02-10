class Group < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :posts, through: :pets, source: :post

  validates :group_name, presence: true
  
  
end
