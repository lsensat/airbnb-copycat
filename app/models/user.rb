class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :flats
  has_many :bookings
  has_many :reviews
  has_many :likes
  has_one :account

  after_create :create_account

  private

  def create_account
    Account.create(user_id: user)
  end

end
