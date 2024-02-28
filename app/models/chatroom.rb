class Chatroom < ApplicationRecord
  has_many :messages
  belongs_to :user
  belongs_to :flat

  validates_uniqueness_of :user, scope: [:flat, :host]
end
