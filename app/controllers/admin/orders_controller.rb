class Admin::OrdersController < Admin::BaseController



  def show
    @order = Order.find(params[:id])
  end
end
