# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  has_many :notifications, dependent: :destroy

  validates :comment_content, presence: true
  validates :customer_id, presence: true
  validates :post_id, presence: true
end
