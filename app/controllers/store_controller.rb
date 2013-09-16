class StoreController < ApplicationController
  def index
    @cats = Cat.order(:created_at)
  end
end
