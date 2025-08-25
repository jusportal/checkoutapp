class HomeController < ApplicationController
  def index
    redirect_to new_cart_url
  end
end
