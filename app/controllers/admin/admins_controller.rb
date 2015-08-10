class Admin::AdminsController < Admin::BaseController
  def index
    @product = Product.new
  end
end
