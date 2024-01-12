class FlatsController < ApplicationController
  def show
    @flat = Flat.find(params[:id])
    @markers = [{ lat: @flat.latitude, lng: @flat.longitude }]
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    if @flat.save
      redirect_to flat_path(@flat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @flat = Flat.find(params[:id])
  end

  def update
    @flat = Flat.find(flat_params)
    if @flat.update
      redirect_to flat_path(@flat)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def flat_params
    params.require(:flat).permit(:title, :description, :address, :zip, :city, :country,
                                :price, :bedrooms, :checkin, :checkout)
  end
end
