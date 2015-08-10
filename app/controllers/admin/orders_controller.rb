class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Orders.all
  end
end
