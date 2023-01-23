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

20.times do |n|
 Customer.create!(
  nick_name: Faker::JapaneseMedia::StudioGhibli.unique.character,
  email:     Faker::Internet.unique.email,
  password:  "passwordpassword")
end

Customer.all.each do |customer|
 2.times do |n|
 Pet.create!(
  customer_id: customer.id,
  group_id: rand(1..3),
  # group_id が3の時だけ作成したい
  pet_kind: Faker::Creature::Animal.name,
  pet_name: Faker::Creature::Dog.name,
  gender:   rand(1..2),
  birthday: Faker::Date.birthday)
 end
end

Customer.all.each do |customer|
 customer.pets.each do |pet|
  2.times do |n|
   Post.create!(
    customer_id: customer.id,
    pet_id: pet.id,
    post_title: Faker::Lorem.sentence,
    post_content: Faker::Lorem.sentence,
    post_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join('app/assets/images/sample-image.jpg')),filename: 'sample-image.jpg')
   )
  end
 end
end



