FactoryBot.define do
  # テストデータの準備
  factory :item do
    item_name             { 'チンチラセレクションプロ' }
    amount                { 1 }
    unit                  { :grams }
    capacity              { 600 }
    association :customer
    
    trait :sheet do
      item_name { 'ペットシーツ 100枚入り' }
      unit      { :sheets }
      capacity  { 100 }
    end
    
    trait :piece do
      item_name { 'VegeDrop' }
      unit      { :pieces }
      capacity  { 30 }
    end
  end
end
