class ChatroomsController < ApplicationController
  def index
    @flats = Flat.all
    @chatrooms = Chatroom.where(user_id: current_user.id)
    @hosts = Chatroom.where(host: current_user.id)
  end

  def new
    @chatroom = Chatroom.new
  end

  def create
    @chatroom = Chatroom.new
    @chatroom.host = @flat.user_id
    @chatroom.user_id = current_user.id
    @chatroom.flat_id = @flat.id
    @chatroom.save
    redirect_to chatroom_path(@chatroom)
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end
end
