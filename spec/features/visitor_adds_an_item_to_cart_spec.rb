require "rails_helper"
require "factory_helper"

feature "Visitor adds an item to their cart" do
  before { build_products }

  context "not logged in with an empty cart" do
    scenario "adds one item to cart twice" do
      item1 = @plants.products.first

      visit product_path(item1)
      click_button "Add to Cart"

      expect(current_path).to eq product_path(item1)
      expect(page).to have_content("added to cart")

      click_button "Add to Cart"
      expect(page).to have_content("added to cart")

      find("#cart").click

      expect(current_path).to eq(cart_path)

      within(".name") do
        expect(page).to have_content("Plant 1")
      end

      within(".quantity") do
        expect(page).to have_content("2")
      end

      within(".total") do
        expect(page).to have_content("$39.98")
      end
    end

    scenario "adds two items to the cart" do
      item1 = @plants.products.first
      item2 = @food.products.last

      visit product_path(item1)
      click_button "Add to Cart"
      click_button "Add to Cart"

      expect(page).to have_content("added to cart")

      visit product_path(item2)
      click_button "Add to Cart"

      expect(page).to have_content("added to cart")

      find("#cart").click

      expect(current_path).to eq(cart_path)
      expect(page).to have_content("Plant 1")
      expect(page).to have_content("2")
      expect(page).to have_content("$39.98")

      expect(page).to have_content("Food 3")
      expect(page).to have_content("1")
      expect(page).to have_content("$39.99")
    end
  end
end
