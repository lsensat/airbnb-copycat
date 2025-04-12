class LikesController < ApplicationController
  before_action :flat_find, only: %i[index edit update]
  before_action :like_find, only: %i[edit update]
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    @likes = Like.where(user: current_user)
  end

  def new
    @like = Like.new
  end

  def create
    @like = Like.new(user_id: current_user.id, flat_id: :flat, liked: true)
    raise
    if @like.save
      respond_to do |format|
        format.html { redirect_to @like, notice: 'Like was successfully created.' }
      end
    else
      render :new, status: :unprocessable
    end
  end

  def edit
    @like = Like.find(params[:id])
  end

  def update
    @like.liked = !@like.liked
    if @like.update(like_params)
      respond_to do |format|
        format.html { redirect_to @like, notice: 'Like was successfully updated.' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def flat_find
    @flat = Flat.where(params[:flat_id])
  end

  def like_find
    @like = Like.where(params[:like_id])
  end

  def like_params
    params.require(:like).permit(:user_id, :flat_id, :liked)
  end
end
