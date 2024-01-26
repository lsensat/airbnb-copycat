class LikesController < ApplicationController
  def create
    @flat = Flat.find(params[:id])
    # @like = Like.new(like_params)

    @like = Like.new(post_id: params[:post_id])

    if @like.save
      render json: { status: "success" }, status: :ok
    else
      render json: { status: "error" }, status: :unprocessable_entity
    end
  end



  private

  def like_params
    params.require(:like).permit(:user_id, :flat_id)
  end
end
