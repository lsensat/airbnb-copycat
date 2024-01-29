class Like < ApplicationRecord
  belongs_to :user
  belongs_to :flat

  validates :user, presence: true
  validates :flat, uniqueness: true
end
