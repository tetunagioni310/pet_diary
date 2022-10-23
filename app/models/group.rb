class Group < ApplicationRecord
  has_many :pets, dependent: :destroy
  
  validates :group_name, presence: true
end
