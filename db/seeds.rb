# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者側
# 管理者を作成
Admin.create!(
  email: 'example@test.com',
  password: 'passwordpassword'
)

# ペット用のグループを作成
Group.create!(
  [
    { group_name: '犬' },
    { group_name: '猫' },
    { group_name: 'その他' }
  ]
)

# 会員側
# メインの会員作成
Customer.create!(
  nick_name: 'test',
  email: 'test@test.com',
  password: 'testtesttest1105'
)

# その他の会員を10回作成
10.times do
  Customer.create!(
    nick_name: Faker::Lorem.characters(number: 15),
    email: Faker::Internet.unique.email,
    password: 'passwordpassword'
  )
end

# 会員それぞれが犬、猫、その他のペットを1匹ずつ作成
Customer.all.each do |customer|
  Group.all.each do |group|
    case group.group_name
    when '犬'
      Pet.create!(
        customer_id: customer.id,
        group_id: group.id,
        pet_kind: Faker::Creature::Animal.name,
        pet_name: Faker::Lorem.characters(number: 8),
        gender: rand(1..2),
        birthday: Faker::Date.between_except(from: '2014-09-23', to: '2020-09-25', excepted: '2015-01-24')
      )
    when '猫'
      Pet.create!(
        customer_id: customer.id,
        group_id: group.id,
        pet_kind: Faker::Creature::Cat.breed,
        pet_name: Faker::Lorem.characters(number: 8),
        gender: rand(1..2),
        birthday: Faker::Date.between_except(from: '2014-09-23', to: '2020-09-25', excepted: '2015-01-24')
      )
    when 'その他'
      Pet.create!(
        customer_id: customer.id,
        group_id: group.id,
        pet_kind: Faker::Creature::Animal.name,
        pet_name: Faker::Lorem.characters(number: 8),
        gender: rand(1..2),
        birthday: Faker::Date.between_except(from: '2014-09-23', to: '2020-09-25', excepted: '2015-01-24')
      )
    end
  end

  # 会員のペットの投稿をそれぞれ一件づつ作成
  customer.pets.each do |pet|
    Post.create!(
      customer_id: customer.id,
      pet_id: pet.id,
      post_title: Faker::Lorem.sentence,
      post_content: Faker::Lorem.sentence,
      post_image: ActiveStorage::Blob.create_and_upload!(
        io: File.open(Rails.root.join('app/assets/images/sample-image.jpg')), filename: 'sample-image.jpg'
      )
    )
  end
end

# フォロー作成
customers = Customer.all

customer  = customers.first
# フォローされている会員
following = customers[2..50]
# フォローしている会員
followers = customers[3..40]

# 1番目の会員が[2..50]をフォローする
following.each { |followed| customer.follow(followed.id) }
# [3..50]の会員が一番目の会員をフォローする
followers.each { |follower| follower.follow(customer.id) }
