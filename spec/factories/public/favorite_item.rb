FactoryBot.define do
  # テストデータ準備
  factory :favorite_item do
    sequence(:favorite_item_name)  { |n| "アイテム#{n}" }
    association :customer
  end
end