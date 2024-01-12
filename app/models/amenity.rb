class Amenity < ApplicationRecord
  has_many :flat_amenities
  has_many :flats, through: :flat_amenities
end
