class Admin::ProductsController < Admin::BaseController
  def new
    @product = Product.new
  end
end
