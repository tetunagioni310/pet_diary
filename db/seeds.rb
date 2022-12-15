# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
   email: 'example@gmail.com',
   password: 'password'
)

Customer.create!(
  [
   {
   email: 'test@test.com',
   password: 'testtest',
   nick_name: 'ymd',
   introduction: 'よろしくお願いします！',
   is_deleted: 'false',
   status: 1
   },

   {
   email: 'kotoko@gmail.com',
   password: 'kotokokotoko',
   nick_name: 'kotoko',
   introduction: 'よろしくお願いします！',
   is_deleted: 'false',
   status: 1
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

Group.create!(
   [
    { group_name: '犬' },
    { group_name: '猫'},
    { group_name: 'その他' }
   ]
)