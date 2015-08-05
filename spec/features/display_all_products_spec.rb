require "rails_helper"

feature "a visitor" do
  context "visits /products" do
    before do
      plants = Category.create(
        name: "Plants",
        description: "The largest selection of carnivorous plants in the world!"
      )

      food = Category.create(
        name: "Food",
        description: "Your carnivorous plants, big or small, are guaranteed" \
          " to love our wide variety of meaty treats."
      )

      accessories = Category.create(
        name: "Accessories",
        description: "From gardening tools to the latest in carnivorous" \
          " botany fashion, we have you covered."
      )

      plants.products.create(
        name: "Plant 1",
        description: "This is the description for plant 1",
        price: 19.99,
        image_url: "plants/plant-2.jpg")
      plants.products.create(
        name: "Plant 2",
        description: "This is the description for plant 2",
        price: 29.99,
        image_url: "plants/plant-3.jpg")
      plants.products.create(
        name: "Plant 3",
        description: "This is the description for plant 3",
        price: 39.99,
        image_url: "plants/venus-fly-traps.jpg")

      food.products.create(
        name: "Food 1",
        description: "This is the description for food 1",
        price: 19.99,
        image_url: "food/bat.jpg")
      food.products.create(
        name: "Food 2",
        description: "This is the description for food 2",
        price: 29.99,
        image_url: "food/beetles.jpg")
      food.products.create(
        name: "Food 3",
        description: "This is the description for food 3",
        price: 39.99,
        image_url: "food/mice.jpg")

      accessories.products.create(
        name: "Accessory 1",
        description: "This is the description for accessory 1",
        price: 19.99,
        image_url: "accessories/kit.jpg")
      accessories.products.create(
        name: "Accessory 2",
        description: "This is the description for accessory 2",
        price: 29.99,
        image_url: "accessories/rocks.jpg")
      accessories.products.create(
        name: "Accessory 3",
        description: "This is the description for accessory 3",
        price: 49.99,
        image_url: "accessories/soil.jpg")
    end

    scenario "and sees all products" do
      visit products_path

      expect(page).to have_selector(".thumbnail", count: 9)
      expect(page).to have_content("Accessory 3")
      expect(page).to have_content("49.99")
      expect(page).to have_xpath("//img[@src=\"/assets/accessories/soil.jpg\"]")
    end

    xscenario "and sees featured products" do
      Product.create(
        name: "Plant 2",
        description: "This is the description for plant 2",
        price: 29.99,
        image_url: "plants/plant-4.jpg")
      Product.create(
        name: "Plant 3",
        description: "This is the description for plant 3",
        price: 39.99,
        image_url: "plants/plant-3.jpg")

      visit product_path(product)

      within("#product-carousel") do
        expect(page).to have_content("Plant 1")
        expect(page).to have_content("19.99")
        expect(page).to have_xpath("//img[@src=\"/assets/plants/plant-2.jpg\"]")
        expect(page).to have_content("Plant 2")
        expect(page).to have_content("29.99")
        expect(page).to have_xpath("//img[@src=\"/assets/plants/plant-4.jpg\"]")
        expect(page).to have_content("Plant 3")
        expect(page).to have_content("39.99")
        expect(page).to have_xpath("//img[@src=\"/assets/plants/plant-3.jpg\"]")
      end
    end
  end
end
