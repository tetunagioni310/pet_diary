FactoryBot.define do
  # テストデータの準備
  factory :customer do
    nick_name             { '会員A' }
    email                 { 'test@gmail.com' }
    password              { '111111' }
    password_confirmation { '111111' }
  end
end
