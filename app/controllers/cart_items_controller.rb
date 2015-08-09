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

  def update
    product_id = params[:id]
    cart.data[product_id] = params[:product][:quantity].to_i
    session[:cart] = cart.data
    redirect_to cart_path
  end

  def destroy
    product = Product.find(params[:id])
    flash[:success] = "Successfully removed " \
                      "<a href=\"#{product_path(product)}\">" \
                      "#{product.name}</a> from your cart."
    cart.delete_item(product)
    redirect_to cart_path
  end
end
