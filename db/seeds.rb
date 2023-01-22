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
  [
   {
   email: 'test@test.com',
   password: 'testtesttest1105',
   nick_name: 'test'
  }
  ]
)



10.times do |n|
 Customer.create!(
  nick_name: "customer#{n+1}",
  email: "customer#{n+1}@example.com",
  password: "password",
  introduction: 'よろしくお願いします！',
  is_deleted: 'false',
  status: 1
  )
end

# Customer.all.each do |customer|
#  Pet.create!(
#   customer_id: customer.id,
#   group_id: rand(1..3),
#   pet_kind: "test",
#   pet_name: "test#{n+1}",
#   pet_introduction: "test",
#   gender: rand(1..2),
#   birthday: "2018-10-15"
#   )
# end