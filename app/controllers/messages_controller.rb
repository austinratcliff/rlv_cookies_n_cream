class MessagesController < ApplicationController
  before_action :authorize

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id

    if @message.save
      MessageMailer.new_message_email_to_user(@message).deliver_now
      MessageMailer.new_message_email_to_lauren(@message).deliver_now
      flash[:success] = 'Your message was sent!'
      redirect_to root_path
    else
      flash[:danger] = 'Your message was not sent — try again!'
      redirect_to new_message_path
    end
  end

  private

    def message_params
      params.require(:message).permit(:body)
    end
end
