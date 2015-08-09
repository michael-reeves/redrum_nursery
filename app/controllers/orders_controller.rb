class OrdersController < ApplicationController
  def index
  end

  def create
    create_order_and_order_items
    clear_cart_and_session_cart
    flash[:success] = "Order was successfully placed!"
    redirect_to orders_path
  end

  private 

  def create_order_and_order_items
    order = Order.create(user_id: current_user.id,
                 status: "Ordered")
    
    cart.cart_items.each do |cart_item|
      OrderItem.create(order_id: order.id,
                       product_id: cart_item.id,
                       quantity: cart_item.quantity,
                       unit_price: cart_item.price)
    end 
  end

  def clear_cart_and_session_cart
    session[:cart] = {}
    cart.clear
  end
end
