class PickupsController < ApplicationController
  before_action :authorize

  def new
    @order = Order.find(params[:order_id])
    @pickup = Pickup.new
  end

  def create
    @order = Order.find(params[:order_id])
    @pickup = Pickup.new(pickup_params)
    @pickup.order_id = @order.id

    if @pickup.save
      @order.delivery.destroy if @order.delivery
      redirect_to @order
    else
      render 'new'
    end
  end

  def edit
    @order = Order.find(params[:order_id])
    @pickup = Pickup.find(params[:id])
  end

  def update
    @order = Order.find(params[:order_id])
    @pickup = Pickup.find(params[:id])

    if @pickup.update_attributes(pickup_params)
      redirect_to @order
    else
      render 'edit'
    end
  end

  private

    def pickup_params
      params.require(:pickup).permit(:pickup_at)
    end
end
