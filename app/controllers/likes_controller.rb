class LikesController < ApplicationController
  def create
    flat = Flat.find(params[:flat_id])
    # @like = Like.new(like_params)

    like = Like.new(user: current_user, flat_id: flat)

    respond_to do |format|
      if like.save
        format.html { redirect_to flats_path }
        format.json # Follows the classic Rails flow and look for a create.json view
      else
        format.html { render flats_path, status: :unprocessable_entity }
        format.json # Follows the classic Rails flow and look for a create.json view
      end
    end
  end



  private

  def like_params
    params.require(:like).permit(:user_id, :flat_id)
  end
end
