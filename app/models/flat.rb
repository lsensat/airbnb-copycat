class Flat < ApplicationRecord
  geocoded_by :address, params: { countrycodes: :country }
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :user
  has_many_attached :photos

  has_many :amenities
end
