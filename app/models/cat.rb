class Cat < ActiveRecord::Base
  has_many :cart_items

  before_destroy :ensure_cat_not_in_any_cart

  private

    # ensure that no one has the cat in their cart before deleting
    def ensure_cat_not_in_any_cart
      if cart_items.empty?
        return true
      else
        errors.add(:base, 'This cat is in a cart. Cannot delete.')
        return false
      end
    end
end
