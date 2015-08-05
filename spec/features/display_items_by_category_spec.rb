require "rails_helper"
require "factory_helper"

feature "a visitor" do
  before do
    build_products
  end

  context "visits /categories/food" do
    scenario "and sees all food products" do
      visit root_path
      within("#food-panel") do
        click_link("Shop Now")
      end

      expect(current_path).to eq(category_path(@food.slug))

      within("h1") do
        expect(page).to have_content("Food")
      end

      within("#category-description") do
        expect(page).to have_content("Your carnivorous plants, big or small," \
          " are guaranteed to love our wide variety of meaty treats.")
      end

      expect(page).to have_selector(".thumbnail", count: 3)
      expect(page).to have_content("Food 3")
      expect(page).to have_content("19.99")
      expect(page).to have_xpath("//img[@src=\"/assets/food/beetles.jpg\"]")
    end
  end

  context "visits /categories/plants" do
    scenario "and sees all plants products" do
      visit root_path
      within("#plants-panel") do
        click_link("Shop Now")
      end

      expect(current_path).to eq(category_path(@plants.slug))

      within("h1") do
        expect(page).to have_content("Plants")
      end

      within("#category-description") do
        expect(page).to have_content("The largest selection of carnivorous")
      end

      expect(page).to have_selector(".thumbnail", count: 3)
      expect(page).to have_content("Plant 3")
      expect(page).to have_content("29.99")
      expect(page).to have_xpath("//img[@src=\"/assets/plants/plant-2.jpg\"]")
    end
  end

  context "visits /categories/accessories" do
    scenario "and sees all accessories" do
      visit root_path
      within("#accessories-panel") do
        click_link("Shop Now")
      end

      expect(current_path).to eq(category_path(@accessories.slug))

      within("h1") do
        expect(page).to have_content("Accessories")
      end

      within("#category-description") do
        expect(page).to have_content("From gardening tools to the latest in")
      end

      expect(page).to have_selector(".thumbnail", count: 3)
      expect(page).to have_content("Accessory 3")
      expect(page).to have_content("19.99")
      expect(page).to have_xpath("//img[@src=\"/assets/accessories/soil.jpg\"]")
    end
  end
end
