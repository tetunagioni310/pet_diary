FactoryBot.define do
  # テストデータ準備
  factory :pet do
    pet_name    { Faker::Lorem.characters(number: 8) }
    pet_kind    { Faker::Lorem.characters(number: 10) }
    gender      { :♂ }
    birthday    { Faker::Date.between_except(from: '2014-09-23', to: '2020-09-25', excepted: '2015-01-24') }
    pet_image do
      ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join('app/assets/images/sample-image.jpg')), filename: 'sample-image.jpg')
    end
    association :group
    association :customer
    
    trait "cat_group" do
      association :group, :cat_group
    end
    
    trait "other_group" do
      association :group, :other_group
    end
  end
end
