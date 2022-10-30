class Expendable < ApplicationRecord
  has_many :works, dependent: :destroy
  belongs_to :pet
end
