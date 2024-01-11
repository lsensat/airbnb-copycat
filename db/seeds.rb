# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

puts 'Deleting previous flats...'
Flat.delete_all
puts 'Deleting previous users...'
User.delete_all

puts 'Creating users...'
10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  user = User.new(
    first_name:,
    last_name:,
    email: Faker::Internet.unique.email(name: "#{first_name} #{last_name}", separators: ['-'], domain: 'gmail'),
    password: 'UsersAreTested1'
  )
  user.save
end
puts 'Users created!'

puts 'Creating flats...'
User.ids.each do |user|
  rand(0..3).floor.times do
    city = Faker::Address.city
    address = Faker::Address.unique.street_name
    country = Faker::Address.country
    flat = Flat.new(
      city:,
      address:,
      zip: Faker::Address.zip_code,
      country:,
      user_id: user,
      description: "Great place to stay and to book! Near a lot of tourist places...",
      rating: rand(2..5),
      price: rand(50..500),
      size: rand(50..300),
      title: "#{%w[Amazing Incredible Awesome].sample} flat at #{address}, #{city}, #{country}"
    )
    flat.save
  end
end
puts 'Flats created!'
