class Flat < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :user
  has_many_attached :photos

  has_many :flat_amenities
  has_many :amenities, through: :flat_amenities

  has_many :bookings, dependent: :destroy

  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy

  include PgSearch::Model
  multisearchable against: [:address, :flat_type, :latitude, :longitude]

end
