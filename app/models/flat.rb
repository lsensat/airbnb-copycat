class Flat < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :user
  has_many_attached :photos

  has_many :flat_amenities
  has_many :amenities, through: :flat_amenities, dependent: :destroy

  has_many :bookings, dependent: :destroy

  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy

  include PgSearch::Model
  multisearchable against: [:address, :flat_type, :latitude, :longitude]

  validates :user, uniqueness: true
  validates :address, uniqueness: true
  validates :flat_type, presence: true
  validates :price, presence: true, comparison: { greater_than: 0 }
  validates :guests, presence: true, comparison: { greater_than_or_equal_to: 1 }
  validates :baths, presence: true, comparison: { greater_than_or_equal_to: 1 }
  validates :bedrooms, presence: true, comparison: { greater_than_or_equal_to: 1 }
  validates :description, length: { maximum: 500 }
end
