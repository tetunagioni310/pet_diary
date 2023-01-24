# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者側
Admin.create!(
   email: 'example@gmail.com',
   password: 'passwordpassword'
)

Group.create!(
  [
    { group_name: '犬' },
    { group_name: '猫'},
    { group_name: 'その他' }
  ]
)

# 会員側
Customer.create!(
   nick_name: 'test',
   email: 'test@test.com',
   password: 'testtesttest1105'
)

5.times do |n|
 Customer.create!(
  nick_name: Faker::Internet.user_name,
  email:     Faker::Internet.unique.email,
  password:  "passwordpassword")
end

Customer.all.each do |customer|
 Pet.create!(
  customer_id: customer.id,
  group_id: 1,
  # group_id が3の時だけ作成したい
  pet_kind: Faker::Creature::Dog.breed,
  pet_name: Faker::Creature::Dog.name,
  gender:   rand(1..2),
  birthday: Faker::Date.between_except( from: '2014-09-23', to: '2020-09-25', excepted: '2015-01-24')
  )
  
  Pet.create!(
  customer_id: customer.id,
  group_id: 2,
  pet_kind: Faker::Creature::Cat.breed,
  pet_name: Faker::Creature::Cat.name,
  gender:   rand(1..2),
  birthday: Faker::Date.between_except( from: '2014-09-23', to: '2020-09-25', excepted: '2015-01-24')
  )
  
  Pet.create!(
  customer_id: customer.id,
  group_id: 3,
  pet_kind: Faker::Creature::Animal.name,
  pet_name: Faker::Creature::Dog.name,
  gender:   rand(1..2),
  birthday: Faker::Date.between_except( from: '2014-09-23', to: '2020-09-25', excepted: '2015-01-24')
  )
 
  customer.pets.each do |pet|
   Post.create!(
    customer_id: customer.id,
    pet_id: pet.id,
    post_title: Faker::Lorem.sentence,
    post_content: Faker::Lorem.sentence,
    post_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join('app/assets/images/sample-image.jpg')),filename: 'sample-image.jpg')
   )
  end
end


