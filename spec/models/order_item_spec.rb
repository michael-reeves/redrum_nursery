require "rails_helper"

RSpec.describe OrderItem, type: :model do
  before do
    user = User.create(first_name: "Jane",
                       last_name:  "Doe",
                       email:      "jane@doe.com",
                       password:   "password")

    order = Order.create(user_id: user.id,
                         status: "ordered")

    category = Category.create(
      name: "Plants",
      description: "The largest carnivorous plant selection in the world!")

    product = Product.create(
      name: "Venus Fly Trap",
      description: "The gold standard of carnivorous plants!",
      image_url: "venus_fly_trap.jpg",
      price: "19.99",
      category_id: category.id)

    @order_item = OrderItem.create(order_id: order.id,
                                   product_id: product.id,
                                   quantity: 1,
                                   unit_price: 19.99)
  end

  it "belongs to an order" do
    expect(@order_item.order.status).to eq("ordered")
  end

  it "has a quantity" do
    expect(@order_item.quantity).to eq(1)
  end

  it "has a unit_price" do
    expect(@order_item.unit_price).to eq(19.99)
  end

  it "has a created_at and updated_at" do
    expect(@order_item.created_at).to be_a_kind_of(ActiveSupport::TimeWithZone)
    expect(@order_item.updated_at).to be_a_kind_of(ActiveSupport::TimeWithZone)
  end
end
