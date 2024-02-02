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
BookingDate.delete_all
Booking.delete_all
puts 'Deleting likes...'
Like.delete_all
puts 'Deleting previous flats...'
Flat.delete_all
puts 'Deleting previous users...'
User.delete_all

total_users = 20

puts 'Creating users...'
require "open-uri"
total_users.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  user = User.new(
    first_name:,
    last_name:,
    email: Faker::Internet.unique.email(name: "#{first_name} #{last_name}", separators: ['-'], domain: 'gmail'),
    password: 'UsersAreTested1'
  )
  face_image = "face-#{rand(1..total_users)}.jpeg"
  file = File.open(File.join(Rails.root, 'app', 'assets', 'images', face_image))
  user.photo.attach(io: file, filename: "avatar.jpeg")
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

User.ids.sample(total_users * 0.8).each_with_index do |user, index|
  flat = Flat.new(
    city: Faker::Address.city, country: Faker::Address.country, bedrooms: rand(1..4),
    price: rand(40..500),
    description: Faker::Lorem.paragraph(sentence_count: rand(4..8)),
    flat_type: "#{['Room', 'Shared Room', 'Place to stay'].sample}",
    street: Faker::Address.street_address, zip: Faker::Address.zip,
    guests: rand(1..5), bath: rand(1..2),
    user_id: user
  )

  def address(flat)
    [flat.street, flat.city, flat.zip, flat.country].compact.join(', ')
  end

  rooms = ['main', 'kitchen', 'living', 'office', 'bathroom']
  rooms.shuffle.each do |room|
    image_room = "#{room}-#{rand(1..10)}.jpeg"
    file_path = File.join(Rails.root, 'app', 'assets', 'images', image_room)
    file = File.open(file_path)
    flat.photos.attach(io: file, filename: image_room)
  end

  flat.address = address(flat)
  flat.save

  Amenity.ids.sample(rand(4..8)).each do |amenity|
    FlatAmenity.create(flat: Flat.last, amenity_id: amenity)
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

puts 'Creating some reviews...'

Flat.all.sample(total_users * 0.9).each do |flat|
  User.all.sample(total_users * rand(0.3..0.9)).each do |user|
    comment = Faker::Lorem.paragraph(sentence_count: rand(2..4))
    rating = rand(1..5)
    flat.reviews.create(user: user, flat: flat, comment: comment, rating: rating)
  end
end

puts 'Reviews created!'

def create_booking_dates(booking, flat)
  flat_price = flat.price

  (booking.start_time..booking.end_time).to_a.each do |date|
    booking.booking_dates.create(date: date, price: flat_price)
  end
end

puts 'Booking some places...'
User.all.sample(total_users * 0.5).each do |user|
  @flat = Flat.all.sample
  year = 2024
  month = rand(2..4)
  day = rand(2..25)
  @booking = Booking.create(user: user, flat: @flat,
    start_time: "#{year}-#{month}-#{day}",
    end_time: "#{year}-#{month}-#{day + rand(2..4)}"
  )

  booking_dates = create_booking_dates(@booking, @flat)
end
puts 'Booked!'

puts 'Creating a testing user...'
User.create(
  first_name: 'luis',
  last_name: 's',
  email: 'test@test.com',
  password: '123123'
)
puts 'Testing user created!'
