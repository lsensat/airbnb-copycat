class LikesController < ApplicationController
  before_action :flat_find, only: %i[create destroy]
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def create
    @like = current_user.likes.new(flat: @flat)

    if @like.save
      render json: { status: 'Success' }
    else
      render json: { errors: @like.error.messages, status: 'error' }
    end
  end

  def delete
    # like_ids = likes.where(flat: flat).ids
    # current_user.likes.where(flat: flat).destroy(like_ids)
  end

  private

  def flat_find
    @flat = Flat.find(params[:flat_id])
  end

  def like_params
    params.require(:like).permit(:user_id, :flat_id)
  end
end
