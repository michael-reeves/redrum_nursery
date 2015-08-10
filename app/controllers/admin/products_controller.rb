class Admin::ProductsController < Admin::BaseController
  def index
    @products = Product.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "#{@product.name} has been added."
      redirect_to admin_dashboard_path
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name,
                                    :description,
                                    :price,
                                    :image_url,
                                    :category_id)
  end
end
