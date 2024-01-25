class BookingsController < ApplicationController
  before_action :set_flat
  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.flat = @flat
    if @booking.save
      (@booking.start_time..@booking.end_time).to_a.each do |date|
        @booking.booking_dates.create(date: date)
      end
      redirect_to flat_path(@flat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_flat
    @flat = Flat.find(params[:flat_id])
  end

  def booking_params
    params.require(:booking).permit(:start_time, :end_time)
  end
end
