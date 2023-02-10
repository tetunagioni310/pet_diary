FactoryBot.define do
  # テストデータ準備
  factory :notification do
    visitor_id    { customer_id }
    visited_id    { customer_id }
    gender      { :♂ }
    birthday    { Faker::Date.between_except(from: '2014-09-23', to: '2020-09-25', excepted: '2015-01-24') }
    
    association :customer
    
    trait "cat_group" do
      association :group, :cat_group
    end
    
    trait "other_group" do
      association :group, :other_group
    end
  end
end
