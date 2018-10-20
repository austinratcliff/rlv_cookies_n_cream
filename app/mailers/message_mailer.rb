class MessageMailer < ApplicationMailer
  default from: 'hello@rlvcookiesncream.com'

  def new_message_email_to_user(message)
    @message = message
    mail(to: @message.user.email, subject: 'Your RLV message was sent!')
  end

  def new_message_email_to_lauren(message)
    @message = message
    mail(to: 'rlvcnc.hello@gmail.com', subject: "New message from #{@message.user.name}!")
  end
end
