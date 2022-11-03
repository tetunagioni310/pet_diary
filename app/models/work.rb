class Work < ApplicationRecord
  belongs_to :customer
  has_many :work_details, dependent: :destroy
end
