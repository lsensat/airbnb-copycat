class FlatsController < ApplicationController
  before_action :set_flat, except: %i[index new create show_photos show_owned_flats open_chat]
  before_action :authenticate_user!, except: %i[index show show_photos]

  def index
    @flats = Flat.all
    if user_signed_in?
      @flats_liked = current_user.likes
    end

    if params[:query].present?
      PgSearch::Multisearch.rebuild(Flat)
      @flats = PgSearch.multisearch(params[:query])
      @markers = @flats.map do |flat|
        {
          lat: flat.searchable.latitude,
          lng: flat.searchable.longitude,
          info_window_html: render_to_string(partial: "info_window", locals: {flat: flat.searchable}),
          marker_html: render_to_string(partial: "marker", locals: {flat: flat.searchable})
        }
      end
    end
  end

  def show
    @markers = [{ lat: @flat.latitude, lng: @flat.longitude }]
    @amenities = Amenity.all
    @identity_verified = true if @flat.user.first_name && @flat.user.last_name
    @bookings = Booking.where(user: current_user)
  end

  def new
    @flat = Flat.new
    @flat_amenities = FlatAmenity.new()
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.address = address(@flat)
    @flat.user = current_user
    if @flat.save
      redirect_to flat_path(@flat)
    else
      render :new, status: :unprocessable_entity # notice: "Couldn't be added: #{@flat.errors.full_messages.join(", ")}"
    end
  end

  def edit
    # edit
  end

  def update
    @flat.address = address(@flat)
    if @flat.update(flat_params)
      redirect_to flat_path(@flat)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @flat.destroy
      redirect_to flats_path
    else
      render :show, status: :unprocessable_entity
    end
  end

  def show_photos
    @flat = Flat.find(params[:flat_id])
  end

  def show_owned_flats
    @flats = Flat.where(user: current_user)
  end

  def open_chat
    @flat = Flat.find(params[:flat_id])
    @chatroom = Chatroom.find_or_create_by(user_id: current_user.id, flat_id: @flat.id, host: @flat.user.id)
    redirect_to chatroom_path(@chatroom)
  end

  private

  def set_flat
    @flat = Flat.find(params[:id])
  end

  def flat_params
    params.require(:flat).permit(:flat_type, :description, :street, :zip, :city, :country,
                                 :price, :bedrooms, :baths, :guests, :checkin, :checkout, photos: [],
                                 amenity_ids: [])
  end

  def address(flat)
    [flat.street, flat.city, flat.zip, flat.country].compact.join(', ')
  end
end
