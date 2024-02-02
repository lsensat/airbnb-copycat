class ReviewsController < ApplicationController
  before_action :set_flat
  before_action :authenticate_user!

  def new
    unless current_user.bookings.where(flat: @flat).empty?
      @review = Review.new
    else
      redirect_to flat_path(@flat), notice: 'First you should have booked this place'
    end
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.flat = @flat
    if @review.save
      redirect_to flat_path(@flat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_flat
    @flat = Flat.find(params[:flat_id])
  end

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
