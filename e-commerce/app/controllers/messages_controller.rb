class MessagesController < ApplicationController
  # previous method omitted

  def new
    @message = Message.new

  end


  def create
    @message = Message.new(message_params)

    if @message.valid?
      MessageMailer.contact_me(@message).deliver_now
      redirect_to message_params, notice: "Message received"
    else
      render :new
    end
  end

  # private method omitted

  private

  def message_params
    params.require(:message).permit(:sujet, :email, :body)
  end
  
end