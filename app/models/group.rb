class Group < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :group, dependent: :destroy

  validates :group_name, presence: true
end
