class CartItem < ActiveRecord::Base
  belongs_to :cat 
  belongs_to :cart 
end
