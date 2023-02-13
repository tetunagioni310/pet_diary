# frozen_string_literal: true

class FavoriteItem < ApplicationRecord
  belongs_to :customer
  has_many :favorite_item_details, dependent: :destroy
  has_many :remember_items, through: :favorite_item_details, source: :item

  validates :customer_id, presence: true
  validates :favorite_item_name, presence: true
end
