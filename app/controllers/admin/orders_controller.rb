class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.all
    @status = :all
  end

  def index_ordered
    @orders = Order.all
    @status = :ordered
    render :index
  end

  def index_paid
    @orders = Order.all
    @status = :paid
    render :index
  end

  def index_cancelled
    @orders = Order.all
    @status = :cancelled
    render :index
  end

  def index_completed
    @orders = Order.all
    @status = :completed
    render :index
  end
end
