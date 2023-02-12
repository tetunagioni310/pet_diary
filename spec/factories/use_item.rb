FactoryBot.define do
  # テストデータ準備
  factory :use_item do
    amount_used  { 10 }
    item_id      { create(:item).id }
    association :customer

    trait :use_sheet_item do
      amount_used { 1 }
      item_id     { create(:item, :sheet).id }
    end
    
    trait :use_piece_item do
      amount_used { 1 }
      item_id     { create(:item, :piece).id }
    end
  end
end