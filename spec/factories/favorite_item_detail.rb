# frozen_string_literal: true

FactoryBot.define do
  # テストデータ準備
  factory :favorite_item_detail do
    amount_used { 10 }
    association :favorite_item
    association :item
  end
end
