class LikesController < ApplicationController
  def create
    @flat = Flat.find(params[:id])
    current_user.likes
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :flat_id)
  end
end
