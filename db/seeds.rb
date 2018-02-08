# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |id|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "1234"
  User.find_or_create_by(email: email) do |user|
    user.name = name
    user.password = password
  end
end

user_ids = User.pluck(:id)

100.times do |id|
  title = Faker::Lorem.sentence 
  content = Faker::Lorem.paragraph
  published_at = Faker::Date.between(2.years.ago, Date.today)
  user_id = user_ids.sample
  Article.find_or_create_by(title: title) do |a|
    a.content = content 
    a.user_id = user_id
    a.published_at = published_at
  end
end

