class ProductsController < ApplicationController
  before_action :load_featured_products, only: [:show]

  def index
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def load_featured_products
    @featured_products = Product.limit(6).order("RANDOM()")
  end
end
