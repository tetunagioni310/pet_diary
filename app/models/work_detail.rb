# frozen_string_literal: true

class WorkDetail < ApplicationRecord
  belongs_to :work
  belongs_to :item
  belongs_to :work
end
