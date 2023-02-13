# frozen_string_literal: true

FactoryBot.define do
  # テストデータ準備
  factory :post do
    post_title  { Faker::Lorem.sentence }
    post_content { Faker::Lorem.sentence }
    post_image  do
      ActiveStorage::Blob.create_and_upload!(
        io: File.open(Rails.root.join("app/assets/images/sample-image.jpg")), filename: "sample-image.jpg"
      )
    end
    association :customer
    association :pet
  end
end
