require "rails_helper"
require "factory_helper"

feature "Visitor" do
  before { build_products }

  context "who is not logged in with an empty cart" do
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
        expect(page).to have_content(item1.name)
      end

      within(".row", text: item1.name) do
        quantity = find(".quantity").value
        expect(quantity).to eq("2")
      end

      within(".total") do
        expect(page).to have_content("$#{item1.price * 2}")
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
      within(".row", text: item1.name) do
        expect(page).to have_content(item1.name)
        quantity = find(".quantity").value
        expect(quantity).to eq("2")
        expect(page).to have_content("$#{item1.price}")
      end

      within(".row", text: item2.name) do
        expect(page).to have_content(item2.name)
        quantity = find(".quantity").value
        expect(quantity).to eq("1")
        expect(page).to have_content("$#{item2.price}")
      end
    end

    scenario "adds two items and updates the quantity of one" do
      item1 = @plants.products.first
      item2 = @food.products.last
      visit product_path(item1)
      click_button "Add to Cart"
      visit product_path(item2)
      click_button "Add to Cart"

      find("#cart").click

      within(".row", text: item1.name) do
        find(".quantity").set("4")
        click_button("update")
      end

      expect(current_path).to eq(cart_path)

      within(".row", text: item1.name) do
        quantity = find(".quantity").value
        expect(quantity).to eq("4")
        expect(page).to have_content("$#{item1.price * 4}")
      end

      within(".total") do
        expect(page).to have_content("$#{item1.price * 4 + item2.price}")
      end
    end

    scenario "adds an item twice and then decreases the quantity to one" do
      item = @plants.products.first
      visit product_path(item)
      click_button "Add to Cart"
      click_button "Add to Cart"

      find("#cart").click
      within(".row", text: item.name) do
        quantity = find(".quantity").value
        expect(quantity).to eq("2")
        expect(page).to have_content("$#{item.price * 2}")
      end

      within(".total") do
        expect(page).to have_content("$#{item.price * 2}")
      end

      within(".row", text: item.name) do
        find(".quantity").set("1")
        click_button("update")
      end

      expect(current_path).to eq(cart_path)

      within(".row", text: item.name) do
        quantity = find(".quantity").value
        expect(quantity).to eq("1")
        within(".sub-total") do
          expect(page).to have_content("$#{item.price}")
        end
      end

      within(".total") do
        expect(page).to have_content("$#{item.price}")
      end
    end

    scenario "adds an item and then clicks the remove link" do
      item = @plants.products.first
      visit product_path(item)
      click_button "Add to Cart"

      find("#cart").click
      within(".row", text: item.name) do
        quantity = find(".quantity").value
        expect(quantity).to eq("1")
        expect(page).to have_content("$#{item.price}")
      end

      within(".total") do
        expect(page).to have_content("$#{item.price}")
      end

      within(".row", text: item.name) do
        click_link("remove")
      end

      expect(current_path).to eq(cart_path)

      within(".flash") do
        expect(page).to have_content("Successfully removed #{item.name} " \
          "from your cart")
        expect(page).to have_link(item.name)
        expect(page).to have_xpath("//a[@href=\"/products/#{item.id}\"]")
      end

      expect(page).not_to have_content(item.description)

      within(".total") do
        expect(page).not_to have_content("$#{item.price}")
        expect(page).to have_content("$0")
      end
    end
  end
end
