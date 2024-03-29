class BookingsController < ApplicationController
  before_action :set_flat, except: %i[index]
  before_action :authenticate_user!

  def index
    @bookings = Booking.where(user: current_user).sort_by { |booking| DateTime.parse(booking.start_time) }.reverse!
    @future_stays = []
    @passed_stays = []
    @bookings.each { |booking| booking.end_time > DateTime.now ? @future_stays.push(booking) : @passed_stays.push(booking) }
    @future_stays.reverse!
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.flat = @flat
    if @booking.save
      create_booking_dates(@booking)
      redirect_to flat_path(@booking.flat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @markers = [{lat: @flat.latitude, lng: @flat.longitude}]
    @booking = Booking.find(params[:id])
  end

  def destroy
    @booking = Booking.find(params[:booking_id])
    if @booking.destroy
      redirect_to user_bookings_path(user_id: current_user.id)
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def create_booking_dates(booking)
    flat_price = booking.flat.price

    (booking.start_time.to_date..booking.end_time.to_date).to_a.each do |date|
      booking.booking_dates.create(date: date, price: flat_price)
    end
  end

  def set_flat
    @flat = Flat.find(params[:flat_id])
  end

  def booking_params
    params.require(:booking).permit(:start_time, :end_time)
  end
end
