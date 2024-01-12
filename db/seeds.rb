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

puts 'Deleting previous amenities...'
FlatAmenity.delete_all
Amenity.delete_all
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

puts 'Create different amenities...'
amenities = ['Kitchen', 'Wifi', 'Shared pool', 'TV', 'Washer', 'Air conditioning',
  'Backyard', 'Carbon monoxide alarm', 'Smoke alarm']

amenities.each do |amenity|
  Amenity.create(name: amenity)
end
puts 'Amenities created!'

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
  Flat.create(
    city: 'Barcelona', country: 'Spain', bedrooms: rand(1..4),
    price: rand(50..500),
    description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false),
    title: "#{flats[index][:address]}, Barcelona",
    address: flats[index][:address], zip: flats[index][:zip],
    user_id: user
  )

  Amenity.ids.each do |amenity|
    FlatAmenity.create(flat_id: Flat.ids.last, amenity_id: amenity, has_amenity: [true, false].sample)
  end

  # amenities.sample(6).each do |amenity|
  #   FlatAmenity.create(name: amenity, flat_id: Flat.ids.last)
  # end
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
