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
Review.delete_all
Flat.delete_all
puts 'Deleting previous users...'
User.delete_all

total_users = 50

cloudinary_public_path = "https://res.cloudinary.com/dylcu4v1a/image/upload/v1706902333/development/airbnb-copycat"

user_faces = {
  "face-1": "face-1_rj8s4v",
  "face-2": "face-2_a3er6f",
  "face-3": "face-3_ticx4h",
  "face-4": "face-4_hcukpe",
  "face-5": "face-5_k3u4cz",
  "face-6": "face-6_lyw5bl",
  "face-7": "face-6_lyw5bl",
  "face-8": "face-8_bgci3p",
  "face-9": "face-9_bdpf0k",
  "face-10": "face-10_taaico",
}

house = {
  "bathroom-1": "bathroom-1_x24yqj",
  "bathroom-2": "bathroom-2_u2kzd5",
  "bathroom-3": "bathroom-3_lagmy5",
  "bathroom-4": "bathroom-4_nnff23",
  "bathroom-5": "bathroom-5_ro0px3",
  "bathroom-6": "bathroom-6_amgnib",
  "bathroom-7": "bathroom-7_lab297",
  "bathroom-8": "bathroom-8_g0fhja",
  "bathroom-9": "bathroom-9_f0mvqk",
  "bathroom-10": "bathroom-10_zplwcd",
  "kitchen-1": "kitchen-2_fayho6",
  "kitchen-2": "kitchen-1_f6vntz",
  "kitchen-3": "kitchen-3_vxuifa",
  "kitchen-4": "kitchen-4_xohcsw",
  "kitchen-5": "kitchen-4_xohcsw",
  "kitchen-6": "kitchen-6_xk3lbn",
  "kitchen-7": "kitchen-7_zh6eat",
  "kitchen-8": "kitchen-8_dwqhvh",
  "kitchen-9": "kitchen-9_vb4ipp",
  "kitchen-10": "kitchen-10_wugk5z",
  "living-1": "living-1_hjvpcu",
  "living-2": "living-2_mm7ytj",
  "living-3": "living-3_jbexm4",
  "living-4": "living-4_qzlpzn",
  "living-5": "living-5_cciufg",
  "living-6": "living-6_be39d7",
  "living-7": "living-7_vdnlnt",
  "living-8": "living-8_ttyidr",
  "living-9": "living-9_tvhxfm",
  "living-10": "living-10_wnhzj2",
  "main-1": "main-1_upknwi",
  "main-2": "main-2_obtzlh",
  "main-3": "main-3_savvci",
  "main-4": "main-4_vukgzc",
  "main-5": "main-5_rmiljf",
  "main-6": "main-6_t2vn6k",
  "main-7": "main-7_qnvrfo",
  "main-8": "main-8_l90rxe",
  "main-9": "main-9_wigspx",
  "main-10": "main-10_wocnzf",
  "office-1": "office-1_uph3xp",
  "office-2": "office-2_eb0ac1",
  "office-3": "office-3_xqnlei",
  "office-4": "office-4_wncwfz",
  "office-5": "office-5_eurduo",
  "office-6": "office-6_znvhjx",
  "office-7": "office-7_bphtcx",
  "office-8": "office-8_zbppre",
  "office-9": "office-9_nvxwrb",
  "office-10": "office-10_fhiuso",
}

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
  face_image = user_faces[:"face-#{rand(1..10)}"]
  face_image_url = "#{cloudinary_public_path}/#{face_image}"
  file = URI.open(face_image_url)
  # file = File.open(File.join(Rails.root, 'app', 'assets', 'images', face_image))
  user.photo.attach(io: file, filename: "#{face_image}")
  user.save
  puts "There are #{User.all.length} users created..."
end
puts 'All users created!'

puts 'Creating different amenities...'
amenities = ['Kitchen', 'Wifi', 'Shared pool', 'TV', 'Washer', 'Air conditioning',
  'Backyard', 'Carbon monoxide alarm', 'Smoke alarm']

amenities.each do |amenity|
  Amenity.create(name: amenity)
end
puts 'Amenities created!'

puts 'Creating flats...'

require "json"

filepath = File.join(Rails.root, 'db', 'data', 'places.json')
serialized_places = File.read(filepath)
places = JSON.parse(serialized_places)

User.ids.sample(places.length).each_with_index do |user, index|
  flat = Flat.new(
    city: places[index]['city'].titleize, country: places[index]['country'].titleize, bedrooms: rand(1..4),
    price: rand(40..500),
    description: Faker::Lorem.paragraph(sentence_count: rand(4..8)),
    flat_type: "#{['Room', 'Shared Room', 'Place to stay'].sample}",
    street: places[index]['street'], zip: places[index]['zip'],
    guests: rand(1..5), baths: rand(1..2),
    user_id: user
  )

  def address(flat)
    [flat.street, flat.city, flat.zip, flat.country].compact.join(', ')
  end

  rooms = ['main', 'kitchen', 'living', 'office', 'bathroom']
  rooms.shuffle!
  rooms.each do |room|
    image_room = house[:"#{room}-#{rand(1..10)}"]
    image_room_url = "#{cloudinary_public_path}/#{image_room}"
    file = URI.open(image_room_url)
    flat.photos.attach(io: file, filename: "#{image_room}")
    # flat.photos.attach(io: URI.open("#{cloudinary_public_path}/#{image_room}.jpeg"), filename: "#{image_room}.jpeg")
    # file_path = File.join(Rails.root, 'app', 'assets', 'images', image_room)
    # file = File.open(file_path)
    # flat.photos.attach(io: file, filename: image_room)
  end

  flat.address = address(flat)
  flat.save

  Amenity.ids.sample(rand(4..8)).each do |amenity|
    FlatAmenity.create(flat: Flat.last, amenity_id: amenity)
  end
  puts "There are #{Flat.all.length} flats created..."
end
puts 'All flats created!'

puts 'Adding some likes...'
Flat.all.each do |flat|
  20.times do
    user = User.all.sample
    Like.create(flat: flat, user: user)
  end
end
puts 'Some flats have likes!'

puts 'Creating some reviews...'

Flat.all.sample(places.length).each do |flat|
  User.all.sample(places.length * rand(0.2..0.6)).each do |user|
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
User.all.sample(total_users).each do |user|
  @flat = Flat.all.sample
  year = rand(2023..2024)
  month = rand(1..12)
  day = rand(1..25)
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
