# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者側
Admin.create!(
  email: 'example@test.com',
  password: 'passwordpassword'
)

Group.create!(
  [
    { group_name: '犬' },
    { group_name: '猫' },
    { group_name: 'その他' }
  ]
)

# 会員側
Customer.create!(
  nick_name: 'test',
  email: 'test@test.com',
  password: 'testtesttest1105'
)

10.times do |_n|
  Customer.create!(
    nick_name: Faker::Internet.user_name(number:15),
    email: Faker::Internet.unique.email,
    password: 'passwordpassword'
  )
end

Customer.all.each do |customer|
  Group.all.each do |group|
    case group.group_name
    when '犬'
      Pet.create!(
        customer_id: customer.id,
        group_id: group.id,
        pet_kind: Faker::Creature::Animal.name,
        pet_name: Faker::Creature::Dog.name(number:8),
        gender: rand(1..2),
        birthday: Faker::Date.between_except(from: '2014-09-23', to: '2020-09-25', excepted: '2015-01-24')
      )
    when '猫'
      Pet.create!(
        customer_id: customer.id,
        group_id: group.id,
        pet_kind: Faker::Creature::Cat.breed,
        pet_name: Faker::Creature::Cat.name(number:8),
        gender: rand(1..2),
        birthday: Faker::Date.between_except(from: '2014-09-23', to: '2020-09-25', excepted: '2015-01-24')
      )
    when 'その他'
      Pet.create!(
        customer_id: customer.id,
        group_id: group.id,
        pet_kind: Faker::Creature::Animal.name,
        pet_name: Faker::Creature::Dog.name(number:8),
        gender: rand(1..2),
        birthday: Faker::Date.between_except(from: '2014-09-23', to: '2020-09-25', excepted: '2015-01-24')
      )
    end
  end

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

customers = Customer.all
customer  = customers.first
# フォローされている
following = customers[2..50]
# フォローしている
followers = customers[3..40]
following.each { |followed| customer.follow(followed.id) }
followers.each { |follower| follower.follow(customer.id) }

# customers = Customer.all
# customer  = customers.first

# following = customers[2..50]
# followers = customers[3..40]

# following.each do |followed|
#   customer.follow(followed.id)
# end

# followers.each do |follower|
#   customer.follow(follower.id)
# end

