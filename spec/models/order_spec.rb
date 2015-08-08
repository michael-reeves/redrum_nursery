require "rails_helper"

RSpec.describe Order, type: :model do
  before do
    user = User.create(first_name: "Jane",
                       last_name:  "Doe",
                       email:      "jane@doe.com",
                       password:   "password")

    @order = Order.create(user_id: user.id,
                          status: "Ordered")
  end

  it "belongs to a user" do
    expect(@order.user.first_name).to eq("Jane")
  end

  it "has a status" do
    expect(@order.status).to eq("Ordered")
  end

  it "has a created_at and updated_at" do
    expect(@order.created_at).to be_a_kind_of(ActiveSupport::TimeWithZone)
    expect(@order.updated_at).to be_a_kind_of(ActiveSupport::TimeWithZone)
  end
end
