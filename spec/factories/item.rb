FactoryBot.define do
  # テストデータの準備
  factory :item do
    item_name             { 'チンチラセレクションプロ' }
    amount                { 1 }
    unit                  { :grams }
    capacity              { 600 }
    association :customer
    
    # trait "中" do
    #   unit { :sheets }
    # end
    
    # trait "pieces" do
    #   unit { :pieces }
    # end
  end
end
