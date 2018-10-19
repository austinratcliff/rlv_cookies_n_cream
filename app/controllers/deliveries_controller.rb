class DeliveriesController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @delivery = Delivery.new
  end

  def create
    @order = Order.find(params[:order_id])
    @delivery = Delivery.new(delivery_params)
    @delivery.order_id = @order.id

    if @delivery.save
      @order.pickup.destroy if @order.pickup
      redirect_to @order
    else
      render 'new'
    end
  end

  def edit
    @order = Order.find(params[:order_id])
    @delivery = Delivery.find(params[:id])
  end

  def update
    @order = Order.find(params[:order_id])
    @delivery = Delivery.find(params[:id])

    if @delivery.update_attributes(delivery_params)
      redirect_to @order
    else
      render 'edit'
    end
  end

  private

    def delivery_params
      params.require(:delivery).permit(:address, :deliver_at)
    end
end
