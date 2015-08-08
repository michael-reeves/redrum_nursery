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

      within(".row", text: "Plant 1") do
        quantity = find(".quantity").value
        expect(quantity).to eq("2")
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

    scenario "adds two items and updates the quantity of one" do
      item1 = @plants.products.first
      item2 = @food.products.last
      visit product_path(item1)
      click_button "Add to Cart"
      visit product_path(item2)
      click_button "Add to Cart"

      find("#cart").click

      within(".row", text: "Plant 1") do
        find(".quantity").set("4")
        click_button("update")
      end

      expect(current_path).to eq(cart_path)

      within(".row", text: "Plant 1") do
        quantity = find(".quantity").value
        expect(quantity).to eq("4")
        save_and_open_page
        expect(page).to have_content("$79.96")
      end

      within(".total") do
        expect(page).to have_content("$119.95")
      end
    end
  end
end
