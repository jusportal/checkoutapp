class CartsController < ApplicationController
  def new
    @cart = Cart.new
  end

  def create
    @cart = Cart.new(cart_params)

    if @cart.save
      redirect_to @cart
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @cart = Cart.find(params[:id])
  end

  private

  def cart_params
    params.require(:cart).permit(:customer_name)
  end
end
