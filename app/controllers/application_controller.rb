class ApplicationController < ActionController::Base
  private

  def average_rating(flat)
    total = 0.0
    flat.reviews.each do |review|
      total += review.rating
    end
    total /= flat.reviews.length
  end
  helper_method :average_rating
end
