class OrdersController < ApplicationController
  def create
    @order = Order.new(order_params)

    if @order.save && @order.cart.recalculate
      redirect_to @order.cart, notice: 'Product added to cart successfully.'
    else
      redirect_to @order.cart, alert: 'Failed to add product to cart.'
    end
  end

  def destroy
    @order = Order.find(params[:id])
    cart = @order.cart
    @order.destroy
    @order.cart.recalculate

    redirect_to cart, notice: 'Product removed from cart successfully.'
  end

  private

  def order_params
    params.require(:order).permit(:product_id, :cart_id, :price_micros)
  end
end
