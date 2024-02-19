class LikesController < ApplicationController
  before_action :flat_find, only: %i[create destroy]
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    @likes = Like.where(user: current_user)
  end

  def create
    @like = current_user.likes.new(flat: @flat)

    if @like.save
      render json: { status: 'success' }
    else
      render json: { errors: @like.errors.full_messages, status: 'error' }
    end
  end

  def destroy
    @like = Like.find(params[:like_id])
    if @like.destroy
      render json: { status: 'success' }
    else
      render json: { errors: @like.errors.full_messages, status: 'error' }
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
