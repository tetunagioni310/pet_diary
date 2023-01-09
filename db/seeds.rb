# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
   email: 'example@gmail.com',
   password: 'passwordpassword'
)

Customer.create!(
  [
   {
   email: 'test@test.com',
   password: 'testtesttest1105',
   nick_name: 'test'
  }
  ]
)

Group.create!(
  [
    { group_name: '犬' },
    { group_name: '猫'},
    { group_name: 'その他' }
  ]
)