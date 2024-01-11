class FlatsController < ApplicationController
  def show
    @flat = Flat.find(params[:id])
  end

  # def new
  #   @flat = Flat.new
  # end

  # def create
  #   @flat = Flat.new(flat_params)
  #   if @flat.save
  #     redirect_to :show
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  private

  def flat_params
    params.require(:flat).permit(:title, :description, :address, :zip, :country, :price, :size)
  end
end
