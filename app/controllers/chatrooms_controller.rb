class ChatroomsController < ApplicationController
  def index
    @flats = Flat.all
    @chatrooms = Chatroom.where(user_id: current_user.id)
    @hosts = Chatroom.where(host: current_user.id)
  end
  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end
end
