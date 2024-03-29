# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :customer
  belongs_to :post

  validates_uniqueness_of :post_id, scope: :customer_id
end
