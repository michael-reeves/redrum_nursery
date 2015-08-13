class ChargesController < ApplicationController
  def create
    total = cart.total_price
    total_in_cents = total * 100

    # Amount in cents
    @amount = total_in_cents.to_i

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => Order.last.id + 1,
      :currency    => 'usd'
    )

    if charge["paid"] == true
      order = Order.create(user_id: current_user.id,
                           status: "paid")

      cart.cart_items.each do |cart_item|
        OrderItem.create(order_id: order.id,
                         product_id: cart_item.id,
                         quantity: cart_item.quantity,
                         unit_price: cart_item.price)
      end 

      session[:cart] = {}
      cart.clear

      flash[:success] = "Your payment was successful and your order is placed."
      redirect_to order_path(order)
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to cart_path
  end
end
