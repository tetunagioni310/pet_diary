FactoryBot.define do
  # テストデータ準備
  factory :schedule do
    schedule_title   { Faker::Lorem.sentence }
    schedule_content { Faker::Lorem.sentence }
    start_time       { Date.today }
    association :customer
  end
end