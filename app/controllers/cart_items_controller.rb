class CartItemsController < ApplicationController
  before_action :set_product, only: [:create, :update, :destroy]

  def index
    @cart_items = cart.cart_items
  end

  def create
    flash[:success] = "#{@product.name} added to cart"
    cart.add_item(@product)
    session[:cart] = cart.data
    redirect_to product_path(@product)
  end

  def update
    cart.update_item_quantity(@product, params[:product][:quantity].to_i)
    session[:cart] = cart.data
    redirect_to cart_path
  end

  def destroy
    flash[:success] = "Successfully removed " \
                      "<a href=\"#{product_path(@product)}\">" \
                      "#{@product.name}</a> from your cart."
    cart.delete_item(@product)
    redirect_to cart_path
  end

  private

  def set_product
    @product = Product.find(params[:id] || params[:product_id])
  end
end
