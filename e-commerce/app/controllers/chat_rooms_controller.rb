class ChatRoomsController < ApplicationController
  def index
    if current_user.roles=="admin"
    @chat_rooms = ChatRoom.all
    else
      @chat_rooms = ChatRoom.where(id: current_user.id)
    end
  end

  def show
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
    @message = Message.new
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    if @chat_room.save
      flash[:success] = 'Chat room added!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end
  end
  def destroy
    @chat_room = ChatRoom.find(params[:id])
    @chat_room.destroy
    redirect_to chat_rooms_path
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end