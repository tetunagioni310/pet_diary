FactoryBot.define do
  # テストデータの準備
  factory :group do
    group_name { '犬' }

    trait :cat_group do
      group_name { '猫' }
    end
    
    trait :other_group do
      group_name { 'その他' }
    end
  end
end