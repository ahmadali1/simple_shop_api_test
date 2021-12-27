# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.create(name: 'Admin', email: 'admin@example.com', password: 'password')
customer = User.create(name: 'Customer', email: 'customer@example.com', password: 'password')
region = Region.create(title: 'South America', country: 'USA', currency: 'USD', tax: 10.10, admin: admin)
Store.create(name: 'Carrefour', region: region, admin: admin)

products = [
 { title: Faker::Book.title, description: Faker::Movies::BackToTheFuture.quote, price: 100.0, sku: Faker::Name.unique.name, stock: 100, region_id: region.id, image_url: Faker::Internet.url},
 { title: Faker::Book.title, description: Faker::Movies::BackToTheFuture.quote, price: 200.0, sku: Faker::Name.unique.name, stock: 100, region_id: region.id, image_url: Faker::Internet.url},
 { title: Faker::Book.title, description: Faker::Movies::BackToTheFuture.quote, price: 300.0, sku: Faker::Name.unique.name, stock: 100, region_id: region.id, image_url: Faker::Internet.url}
]

Product.create(products)
