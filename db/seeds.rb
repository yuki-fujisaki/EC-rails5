# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#追記
Admin.create!(
    email: "a@a",
    password: "aaaaaa"
)

Genre.create!([
    { name: 'ケーキ'},
    { name: 'プリン' },
    { name: '焼き菓子' },
    { name: 'キャンディ' }
  ])

Item.create!([
    {
    name: 'ケーキ',
    image: File.open('./app/assets/images/ケーキ.jpg'),
    description: '甘くて美味しい',
    tax_excluded_price: 1000,
    is_active: false,
    genre_id: 1
    },
    {
    name: 'クッキー',
    image: File.open('./app/assets/images/クッキー.jpg'),
    description: 'サクサク',
    tax_excluded_price: 500,
    is_active: false,
    genre_id: 3
    }
  ])
