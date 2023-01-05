FactoryBot.define do
  # テストデータの準備
  factory :admin do
    email                 {"example@gmail.com"}
    password              {"passwordpassword"}
    password_confirmation {"passwordpassword"}
  end
end