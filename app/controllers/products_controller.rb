class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    load_featured_products
    @product = Product.find(params[:id])
  end
end
