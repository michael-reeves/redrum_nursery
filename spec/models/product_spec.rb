require "rails_helper"

RSpec.describe Product, type: :model do
  let(:category) do
    Category.create(
      name: "Plants",
      description: "The largest carnivorous plant selection in the world!")
  end

  it "is created and belongs to a category" do
    product = Product.create(
      name: "Venus Fly Trap",
      description: "The gold standard of carnivorous plants!",
      image_url: "venus_fly_trap.jpg",
      price: "19.99",
      category_id: category.id)

    expect(product.name).to eq("Venus Fly Trap")
    expect(product.description).to eq(
      "The gold standard of carnivorous plants!")
    expect(product.image_url).to eq("venus_fly_trap.jpg")
    expect(product.price).to eq(19.99)

    expect(product.category.name).to eq("Plants")
    expect(product.category.description).to eq(
      "The largest carnivorous plant selection in the world!")
  end

  it "requires a name" do
    product = Product.create(
      name: nil,
      description: "The gold standard of carnivorous plants!",
      image_url: "venus_fly_trap.jpg",
      price: "19.99",
      category_id: category.id)

    expect(product).to_not be_valid
  end

  it "requires a price" do
    product = Product.create(
      name: "Venus Fly Trap",
      description: "The gold standard of carnivorous plants!",
      image_url: "venus_fly_trap.jpg",
      price: nil,
      category_id: category.id)

    expect(product).to_not be_valid
  end
end
