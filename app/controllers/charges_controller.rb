class ChargesController < ApplicationController
  def create
    @order = Order.find(params[:order_id])
    total = @order.total
    total_in_cents = total * 100
    flash[:success] = "Your payment was submitted."
    @order.update(status: "paid")

    # Amount in cents
    @amount = total_in_cents.to_i

    customer = Stripe::Customer.create(
      :email => @order.user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    redirect_to order_path(@order)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to orders_path
  end
end
