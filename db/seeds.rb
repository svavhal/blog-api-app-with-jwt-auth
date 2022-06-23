# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.destroy_all
Post.destroy_all

user = User.create!(
  name: 'sandip',
  email: 'sandip.vavhal@gmail.com',
  password: 'Admin@1234',
  password_confirmation: 'Admin@1234'
)

post = user.posts.create!(
  title: 'test title',
  body: 'test body',
)

post.comments.create!(
  body: 'test body',
  user_id: user.id
)