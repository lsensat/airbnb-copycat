class LikesController < ApplicationController
  before_action :flat_find, only: %i[create destroy]
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def create
    @like = current_user.likes.new(flat: @flat)

    respond_to do |format|
      if @like.save
        format.html { redirect_to flats_path(@like) }
        format.json # Follows the classic Rails flow and look for a create.json view
      else
        format.html { render "flats", status: :unprocessable_entity }
        format.json # Follows the classic Rails flow and look for a create.json view
      end
    end
  end

  def destroy
    @like = current_user.likes.destroy(flat: @flat)

    respond_to do |format|
      if @like.save
        format.html { redirect_to flats_path(@like) }
        format.json # Follows the classic Rails flow and look for a create.json view
      else
        format.html { render "flats", status: :unprocessable_entity }
        format.json # Follows the classic Rails flow and look for a create.json view
      end
    end
  end

  private

  def flat_find
    @flat = Flat.find(params[:flat_id])
  end

  def like_params
    params.require(:like).permit(:user_id, :flat_id)
  end
end
