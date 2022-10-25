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
   {
   email: 'test@test.com',
   password: 'testtest',
   nick_name: 'ymd',
   introduction: 'よろしくお願いします！',
   is_deleted: 'false'
   }
)

Group.create!(
   [
    { group_name: '犬' },
    { group_name: '猫'},
    { group_name: 'ハムスター' },
    { group_name: 'トカゲ' },
    { group_name: 'デグー' },
    { group_name: 'チンチラ'},
    { group_name: 'モルモット' },
    { group_name: 'うさぎ' },
    { group_name: 'リス' },
    { group_name: 'ジリス' },
    { group_name: 'フェレット'},
    { group_name: 'インコ' },
    { group_name: 'オウム' },
    { group_name: 'モモンガ' },
    { group_name: 'ハリネズミ'},
    { group_name: 'その他小動物' },
    { group_name: 'その他鳥' }
   ]
)