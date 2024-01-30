class Account < ApplicationRecord
  has_one_attached :photos
  belongs_to :user

  include PgSearch::Model
  multisearchable against: [:first_name, :last_name]

end
