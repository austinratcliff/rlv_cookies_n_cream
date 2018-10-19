class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id

    if @message.save
      flash[:sent] = 'Your message was sent!'
      redirect_to root_path
    else
      flash.now[:not_sent] = 'Your message was not sent — try again!'
      render 'new'
    end
  end

  private

    def message_params
      params.require(:message).permit(:body)
    end
end
