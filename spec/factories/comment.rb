FactoryBot.define do
  # テストデータ準備
  factory :comment do
    comment_content  { Faker::Lorem.sentence }
    association :customer
    association :post
  end
end