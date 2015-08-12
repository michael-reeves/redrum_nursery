require "rails_helper"

RSpec.describe Order, type: :model do
  before do
    user = User.create(first_name: "Jane",
                       last_name:  "Doe",
                       email:      "jane@doe.com",
                       password:   "password")

    @order = user.orders.create(status: "ordered")

    category = Category.create(
      name: "Plants",
      description: "The largest carnivorous plant selection in the world!")

    product_1 = Product.create(
      name: "Venus Fly Trap",
      description: "The gold standard of carnivorous plants!",
      image_url: "venus_fly_trap.jpg",
      price: "19.99",
      category_id: category.id)

    product_2 = Product.create(
      name: "Plant 2",
      description: "Plant 2 description",
      image_url: "image.png",
      price: "19.99",
      category_id: category.id)

    OrderItem.create(order_id: @order.id,
                     product_id: product_1.id,
                     quantity: 2,
                     unit_price: 19.99)

    OrderItem.create(order_id: @order.id,
                     product_id: product_2.id,
                     quantity: 1,
                     unit_price: 24.99)
  end

  it "belongs to a user" do
    expect(@order.user.first_name).to eq("Jane")
  end

  it "is valid with a status of ordered" do
    expect(@order.status).to eq("ordered")
    expect(@order).to be_valid
  end

  it "is valid with a status of paid" do
    @order.status = "paid"
    expect(@order).to be_valid
  end

  it "is valid with a status of cancelled" do
    @order.status = "cancelled"
    expect(@order).to be_valid
  end

  it "is valid with a status of completed" do
    @order.status = "completed"
    expect(@order).to be_valid
  end

  it "is invalid with a blank status" do
    @order.status = ""
    expect(@order).to be_invalid
  end

  it "is invalid with a nil status" do
    @order.status = nil
    expect(@order).to be_invalid
  end

  it "is invalid with a whatever status" do
    expect { @order.status = "whatever" }.to raise_error(ArgumentError)
  end

  it "has a created_at and updated_at" do
    expect(@order.created_at).to be_a_kind_of(ActiveSupport::TimeWithZone)
    expect(@order.updated_at).to be_a_kind_of(ActiveSupport::TimeWithZone)
  end

  it "has many order items" do
    expect(@order.order_items.first.quantity).to eq(2)
    expect(@order.order_items.last.quantity).to eq(1)
  end

  it "returns the correct #total for an order" do
    expect(@order.total).to eq(64.97)
  end

  it "returns cancel and completed for #available_status_transitions if status is paid" do
    @order.status = "paid"

    expect(@order.available_status_transitions).to eq(["cancelled", "completed"])
  end

  it "returns cancel and paid for #available_status_transitions if status is ordered" do
    @order.status = "ordered"

    expect(@order.available_status_transitions).to eq(["cancelled", "paid"])
  end

  it "returns an empty array for #available_status_transitions if status is cancelled or completed" do
    @order.status = "cancelled"
    expect(@order.available_status_transitions).to eq([])

    @order.status = "completed"
    expect(@order.available_status_transitions).to eq([])
  end
end
