class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def calendly
    order_id = params[:utm_source].to_i
    @order = Order.find(order_id)
    sleep 1
    redirect_to @order
  end

  def calendly_create
    data = JSON.parse(request.body.read)
    event = data['payload']['event_type']['name']
    start_time = data['payload']['event']['start_time']
    location = data['payload']['event']['location']
    cancel_url = "https://calendly.com/cancellations/#{data['payload']['invitee']['uuid']}"
    order_id = data['payload']['tracking']['utm_source'].to_i
    @order = Order.find(order_id)
    @order.update_attributes(cancel_url: cancel_url)

    if event == 'Pickup'
      pickup = Pickup.new(pickup_at: start_time)
      pickup.order_id = @order.id

      if pickup.save
        @order.delivery.destroy if @order.delivery
        OrderMailer.new_order_email_to_user(@order).deliver_now
        OrderMailer.new_order_email_to_lauren(@order).deliver_now
      end
    elsif event == 'Delivery'
      delivery = Delivery.new(address: location, deliver_at: start_time)
      delivery.order_id = @order.id

      if delivery.save
        @order.pickup.destroy if @order.pickup
        OrderMailer.new_order_email_to_user(@order).deliver_now
        OrderMailer.new_order_email_to_lauren(@order).deliver_now
      end
    end
  end

  def calendly_destroy
    data = JSON.parse(request.body.read)
    order_id = data['payload']['tracking']['utm_source'].to_i
    @order = Order.find(order_id)
    @order.destroy
  end
end
