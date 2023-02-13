# frozen_string_literal: true

FactoryBot.define do
  # テストデータ準備
  factory :work do
    sequence(:work_name)  { |n| "ワーク#{n}" }
    association :customer
    association :pet
  end
end
