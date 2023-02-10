FactoryBot.define do
  # テストデータ準備
  factory :relationship do
   follower_id { FactoryBot.create(:customer).id }
   followed_id { FactoryBot.create(:customer).id }
  end
end
