require 'rails_helper'

RSpec.describe Category, type: :model do
  it "can have two products" do
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
      name: "Pitcher Plant",
      description: "The silver standard of carnivorous plants!",
      image_url: "pitcher_plant.jpg",
      price: "14.99",
      category_id: category.id)

    expect(category.name).to eq("Plants")
    expect(category.description).to eq("The largest carnivorous plant selection in the world!")

    expect(category.products.find(product_1.id).name).to eq("Venus Fly Trap")
    expect(category.products.find(product_1.id).description).to eq("The gold standard of carnivorous plants!")
    expect(category.products.find(product_1.id).image_url).to eq("venus_fly_trap.jpg")
    expect(category.products.find(product_1.id).price).to eq(19.99)
    
    expect(category.products.find(product_2.id).name).to eq("Pitcher Plant")
    expect(category.products.find(product_2.id).description).to eq("The silver standard of carnivorous plants!")
    expect(category.products.find(product_2.id).image_url).to eq("pitcher_plant.jpg")
    expect(category.products.find(product_2.id).price).to eq(14.99)
  end

  it "requires a name" do
    category = Category.create(
      name: nil,
      description: "The largest carnivorous plant selection in the world!")

    expect(category).to_not be_valid
  end
end
