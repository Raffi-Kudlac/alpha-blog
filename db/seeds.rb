# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username: "Admin", email: "admin@alphaapp.org",
  password: "password", admin: true)

50.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@alphaapp.org"
  password = "password"
  User.create!(username:  name,
               email: email,
               password: password)
end

users = User.all

users.each do |user|
  21.times do |n|
    desc = Faker::Lorem.sentence(10)
    title =Faker::Lorem.characters(8)
    user.articles.create!(description: desc, title: title)
  end
end

Category.create(name: "Sports")
Category.create(name: "Food")

10.times do |n|
  name = Faker::Ancient.god
  Category.create(name: name)
end

article = Article.first
article.categories.push(Category.first)
article.categories.push(Category.second)
