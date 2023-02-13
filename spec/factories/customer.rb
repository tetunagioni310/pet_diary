# frozen_string_literal: true

FactoryBot.define do
  # テストデータの準備
  factory :customer do
    sequence(:nick_name)  { |n| "会員#{n}" }
    sequence(:email)      { |n| "test#{n}@test.com" }
    password              { "111111" }
    password_confirmation { "111111" }
    customer_image do
      ActiveStorage::Blob.create_and_upload!(
        io: File.open(Rails.root.join("app/assets/images/sample-image.jpg")), filename: "sample-image.jpg"
      )
    end
  end
end
