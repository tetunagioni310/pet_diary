FactoryBot.define do
  # テストデータ準備
  factory :use_item do
    amount_used  { 1000 }
    association :customer
    association :item
  end
end