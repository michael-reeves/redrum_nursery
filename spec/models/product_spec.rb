require "rails_helper"

RSpec.describe Product, type: :model do
  let(:category) do
    Category.create(
      name: "Plants",
      description: "The largest carnivorous plant selection in the world!")
  end

  let(:product) do
    category.products.create(
      name: "Venus Fly Trap",
      description: "The gold standard of carnivorous plants!",
      image_url: "venus_fly_trap.jpg",
      price: "19.99")
  end

  it "is created and belongs to a category" do
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
    product.name = nil

    expect(product).to_not be_valid
  end

  it "requires a unique name" do
    category.products.create(
      name: "Venus Fly Trap",
      description: "The gold standard of carnivorous plants!",
      image_url: "venus_fly_trap.jpg",
      price: "19.99")
    product_2 = category.products.create(
      name: "Venus Fly Trap",
      description: "Some other description",
      image_url: "another_image.jpg",
      price: "9.99")

    expect(product_2).to_not be_valid
  end

  it "requires a description" do
    product.description = nil

    expect(product).to_not be_valid
  end

  it "requires a price" do
    product.price = nil

    expect(product).to_not be_valid
  end

  it "requires a numeric price" do
    product.price = "abc"

    expect(product).to_not be_valid
  end

  it "requires price to be greater than zero" do
    product.price = "0.00"

    expect(product).to_not be_valid
  end

  it "requires a category" do
    no_category_product = Product.create(
      name: "Venus Fly Trap",
      description: "The gold standard of carnivorous plants!",
      image_url: "venus_fly_trap.jpg",
      price: "19.99")

    expect(no_category_product).to_not be_valid
  end
end
