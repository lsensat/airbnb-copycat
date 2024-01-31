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
puts 'Deleting bookings...'
Booking.delete_all
puts 'Deleting likes...'
Like.delete_all
puts 'Deleting previous flats...'
Flat.delete_all
puts 'Deleting previous users...'
User.delete_all

puts 'Creating users...'
require "open-uri"
10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  user = User.new(
    first_name:,
    last_name:,
    email: Faker::Internet.unique.email(name: "#{first_name} #{last_name}", separators: ['-'], domain: 'gmail'),
    password: 'UsersAreTested1'
  )
  file = URI.open("https://thispersondoesnotexist.com/")
  user.photo.attach(io: file, filename: "avatar.png", content_type: "image/png")
  user.save
end
puts 'Users created!'

puts 'Creating different amenities...'
amenities = ['Kitchen', 'Wifi', 'Shared pool', 'TV', 'Washer', 'Air conditioning',
  'Backyard', 'Carbon monoxide alarm', 'Smoke alarm']

amenities.each do |amenity|
  Amenity.create(name: amenity)
end
puts 'Amenities created!'

puts 'Creating flats...'

User.ids.sample(10).each_with_index do |user, index|
  flat = Flat.new(
    city: Faker::Address.city, country: Faker::Address.country, bedrooms: rand(1..4),
    price: rand(50..500),
    description: Faker::Lorem.paragraph(sentence_count: rand(2..4)),
    flat_type: "#{['Room', 'Shared Room', 'Place to stay'].sample}",
    street: Faker::Address.street_address, zip: Faker::Address.zip,
    user_id: user
  )

  def address(flat)
    [flat.street, flat.city, flat.zip, flat.country].compact.join(', ')
  end

  rooms = ['kitchen', 'living', 'main', 'office', 'bathroom'].shuffle
  rooms.each do |room|
    image_room = "#{room}-#{rand(1..4)}.jpeg"
    file_path = File.join(Rails.root, 'app', 'assets', 'images', image_room)
    file = File.open(file_path)
    flat.photos.attach(io: file, filename: image_room, content_type: "image/jpeg")
  end

  flat.address = address(flat)
  flat.save

  random_amenities = rand(4..8)
  Amenity.ids.sample(random_amenities).each do |amenity|
    FlatAmenity.create(flat_id: Flat.ids.last, amenity_id: amenity)
  end
end
puts 'Flats created!'

puts 'Adding some likes...'
Flat.all.each do |flat|
  30.times do
    user = User.all.sample
    Like.create(flat: flat, user: user)
  end
end
puts 'Some flats have likes!'

puts 'Creating a testing user...'
User.create(
  first_name: 'luis',
  last_name: 's',
  email: 'test@test.com',
  password: '123123'
)
puts 'Testing user created!'
