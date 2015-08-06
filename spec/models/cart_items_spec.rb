require "rails_helper"

describe CartItem do
  let(:product) do
    Product.create(name:        "Plant 1",
                   description: "Plant 1 description",
                   price:       29.99)
  end

  it "has a product and a quantity" do
    cart_item = CartItem.new(product, 2)

    expect(cart_item.name).to eq("Plant 1")
    expect(cart_item.description).to eq("Plant 1 description")
    expect(cart_item.price).to eq(29.99)

    expect(cart_item.quantity).to be(2)
  end

  context "#item_total" do
    it "returns the quantity times the price" do
      cart_item = CartItem.new(product, 2)

      expect(cart_item.item_total).to eq(59.98)
    end
  end
end
