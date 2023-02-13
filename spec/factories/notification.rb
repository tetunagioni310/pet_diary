# frozen_string_literal: true

FactoryBot.define do
  # テストデータ準備
  factory :notification do
    visitor_id    { create(:customer).id }
    visited_id    { create(:customer).id }
    action        { 'follow' }
    
    trait :comment do
      action { 'comment' }
      association :post
      association :comment
    end

    trait :like do
      action { 'like' }
      association :post
    end
  end
end
