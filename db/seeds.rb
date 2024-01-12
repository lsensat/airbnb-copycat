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
flats = [
  { address: 'Carrer de Freixa, 36', zip: '08021' },
  { address: 'C/ de Muntaner, 102', zip: '08036' },
  { address: 'C. del dos de Maig, 234I', zip: '08026' },
  { address: 'Carrer dels Paletes, 3', zip: '08034' },
  { address: 'C/ de Tarragona, 141', zip: '08014' },
  { address: 'Carrer de la Perla, 21', zip: '08012' },
  { address: 'C/ de València, 430', zip: '08013' },
  { address: 'C. de Pujades, 170', zip: '08005' },
  { address: 'Carrer de Mercedes, 2', zip: '08024' },
  { address: 'Sant Marius 13', zip: '08022' }
]

User.ids.sample(10).each_with_index do |user, index|
  puts flats[index][:address]
  Flat.create(
    city: 'Barcelona', country: 'Spain', rating: rand(2..5), bedrooms: rand(1..4),
    price: rand(50..500),
    description: 'Great place to stay and to book! Near a lot of tourist places...',
    title: '',
    address: flats[index][:address].to_s, zip: flats[index][:zip].to_s,
    user_id: user
  )
end
puts 'Flats created!'

puts 'Creating a testing user...'
User.create(
  first_name: 'luis',
  last_name: 's',
  email: 'test@test.com',
  password: '123123'
)
puts 'Testing user created!'
