class FlatsController < ApplicationController
  before_action :set_flat, except: %i[index new create]

  def index
    @flats = Flat.all
    if params[:query].present?
      PgSearch::Multisearch.rebuild(Flat)
      PgSearch::Multisearch.rebuild(User)
      @flats = PgSearch.multisearch(params[:query])
      @markers = @flats.map do |flat|
        {
          lat: flat.searchable.latitude,
          lng: flat.searchable.longitude
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

  def delete
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
    params.require(:flat).permit(:title, :description, :street, :zip, :city, :country,
                                 :price, :bedrooms, :baths, :guests, :checkin, :checkout, photos: [],
                                 amenity_ids: [])
  end

  def address(flat)
    [flat.street, flat.city, flat.zip, flat.country].compact.join(', ')
  end
end
