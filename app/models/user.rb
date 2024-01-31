class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :flats
  has_many :bookings
  has_many :reviews
  has_many :likes
  has_one_attached :photo

  include PgSearch::Model
  multisearchable against: [:first_name, :last_name]
end
