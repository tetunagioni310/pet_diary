# frozen_string_literal: true

FactoryBot.define do
  # テストデータ準備
  factory :like do
    association :customer
    association :post
  end
end
