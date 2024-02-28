class Chatroom < ApplicationRecord
  has_many :messages
  belongs_to :user
  belongs_to :host
  belongs_to :flat
end
