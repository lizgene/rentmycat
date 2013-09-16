class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:show, :edit, :update, :destroy]

  # GET /cart_items
  # GET /cart_items.json
  def index
    @cart_items = CartItem.all
  end

  # GET /cart_items/1
  # GET /cart_items/1.json
  def show
  end

  # GET /cart_items/new
  def new
    @cart_item = CartItem.new
  end

  def edit
  end

  def create
    @cart = current_cart 
    cat = Cat.find(params[:cat_id])

    unless @cart.cart_items.find_by_cat_id(cat.id) != nil
      @cart_item = @cart.cart_items.build
      @cart_item.cat = cat

      respond_to do |format|
        if @cart_item.save
          format.html { redirect_to @cart_item.cart, notice: 'Successfully added adorable kitty!' }
          format.json { render json: @cart_item, status: :created, location: @cart_item }
        else
          format.html { render action: 'new', notice: 'Oh noes! There was an error updating your cart.' }
          format.json { render json: @cart_item.errors, status: :unprocessable_entity }
        end
      end
      else
        flash[:notice] = "You're crazy bananas! You can't add a cat to your cart twice!"
        redirect_to '/'
      end
  end

  def update
    respond_to do |format|
      if @cart_item.update(cart_item_params)
        format.html { redirect_to @cart_item, notice: 'Cart item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cart_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_items_url }
      format.json { head :no_content }
    end
  end

  private
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end
    def cart_item_params
      params.require(:cart_item).permit(:cat_id, :cart_id)
    end
end
