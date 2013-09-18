class StoreController < ApplicationController
  def index
    @cats = Cat.order(:created_at)
    @cart = current_cart
  end
end
