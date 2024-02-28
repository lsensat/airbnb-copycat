class Review < ApplicationRecord
  belongs_to :user
  belongs_to :flat

  validates :comment, presence: true, length: { in: 2..500 }
  validates :rating, comparison: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
