class CartItem < ActiveRecord::Base
  belongs_to :cat 
  belongs_to :cart 

  def total_price
    cat.price * quantity
  end
end
