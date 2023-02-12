FactoryBot.define do
  # テストデータ準備
  factory :work_detail do
    amount_used  { 10 }
    association :item
    association :work
  end
end