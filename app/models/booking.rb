class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :flat
  has_many :booking_dates, dependent: :destroy

  validates :start_time, comparison: { greater_than: Date.today.to_s }
  validates :end_time, comparison: { greater_than: :start_time }
  validates_uniqueness_of :user, scope: [:flat, :booking_dates]
end
