class FlatsController < ApplicationController
  before_action :set_flat, except: %i[index new create destroy show_photos]
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
