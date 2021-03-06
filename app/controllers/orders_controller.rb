class OrdersController < ApplicationController
  before_action :authorize

  def new
    @order = Order.new
    @counts = [
      [6, 'Half dozen'],
      [12, 'One dozen'],
      [24, 'Two dozen'],
      [36, 'Three dozen'],
      [nil, "Let's chat"]
    ]
    @colors = [
      ['Red'],
      ['Orange'],
      ['Yellow'],
      ['Green'],
      ['Blue'],
      ['Purple'],
      ['Pink'],
      ['White'],
      ['Gray'],
      ['Black'],
      ['Brown'],
      ['Gold'],
      ['Silver']
    ]
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.colors = params[:order][:colors]

    if @order.save
      if @order.is_delivery
        flash[:success] = 'Step 1 of 2 is complete — now schedule your delivery!'
        redirect_to new_order_delivery_path(@order)
      else
        flash[:success] = 'Step 1 of 2 is complete — now schedule your pickup!'
        redirect_to new_order_pickup_path(@order)
      end
    else
      render 'new'
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  # def edit
  #   @order = Order.find(params[:id])
  #   @counts = [
  #     [6, 'Half dozen'],
  #     [12, 'One dozen'],
  #     [24, 'Two dozen'],
  #     [36, 'Three dozen'],
  #     [nil, "Let's chat"]
  #   ]
  # end
  #
  # def update
  #   @order = Order.find(params[:id])
  #
  #   if @order.update_attributes(order_params)
  #     if @order.is_delivery
  #       if @order.delivery
  #         redirect_to edit_order_delivery_path(@order, @order.delivery)
  #       else
  #         redirect_to new_order_delivery_path(@order)
  #       end
  #     else
  #       if @order.pickup
  #         redirect_to edit_order_pickup_path(@order, @order.pickup)
  #       else
  #         redirect_to new_order_pickup_path(@order)
  #       end
  #     end
  #   else
  #     render 'edit'
  #   end
  # end
  #
  # def destroy
  #   Order.find(params[:id]).destroy
  #   redirect_to current_user
  # end

  private

    def order_params
      params.require(:order).permit(:count, :description, :allergies, :is_delivery)
    end
end
