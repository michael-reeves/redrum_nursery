class CartItemsController < ApplicationController
  def index
    @cart_items = cart.cart_items
  end

  def create
    product = Product.find(params[:product_id])
    flash[:success] = "#{product.name} added to cart"
    cart.add_item(product)
    session[:cart] = cart.data
    redirect_to product_path(product)
  end
end
