class OrderMailer < ApplicationMailer
  default from: 'hello@rlvcookiesncream.com'

  def new_order_email_to_user(order)
    @order = order
    mail(to: @order.user.email, subject: 'Your RLV order was submitted!')
  end

  def new_order_email_to_lauren(order)
    @order = order
    mail(to: 'rlvcnc.hello@gmail.com', subject: "New order from #{@order.user.name}!")
  end
end
