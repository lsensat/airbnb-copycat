class Like < ApplicationRecord
  belongs_to :user
  belongs_to :flat

  validates_uniqueness_of :user, scope: :flat
end
