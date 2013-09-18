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

    if @cart.cart_items.find_by_cat_id(cat.id)
      flash[:notice] = "You're crazy bananas! You can't add a cat to your cart twice!"
      return redirect_to '/'
    end

    @cart_item = @cart.cart_items.build
    @cart_item.cat = cat

      respond_to do |format|
        if @cart_item.save
          format.html { redirect_to store_url }
          format.js { @current_item = @cart_item }
          format.json { render json: @cart_item, status: :created, location: @cart_item }
        else
          format.html { render action: 'new', notice: 'Oh noes! There was an error updating your cart.' }
          format.json { render json: @cart_item.errors, status: :unprocessable_entity }
        end
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
    @cart = current_cart 
    respond_to do |format|
      if @cart_item.destroy
        format.html { redirect_to store_url }
        format.js { @current_item = @cart_item }
        format.json { head :no_content }
      end
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
