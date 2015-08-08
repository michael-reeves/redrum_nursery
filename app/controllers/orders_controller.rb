class OrdersController < ApplicationController
  def index
  end

  def create
    order = Order.create(user_id: current_user.id,
                 status: "Ordered")
    
    cart.cart_items.each do |cart_item|
      OrderItem.create(order_id: order.id,
                       product_id: cart_item.id,
                       quantity: cart_item.quantity,
                       unit_price: cart_item.price)
    end 

    session[:cart] = {}
    cart.clear

    flash[:success] = "Order was successfully placed!"
    redirect_to orders_path
  end
end
