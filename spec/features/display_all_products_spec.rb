require "rails_helper"
require "factory_helper"

feature "a visitor" do
  context "visits /products" do
    before do
      build_products
    end

    scenario "and sees all products" do
      visit products_path

      expect(page).to have_selector(".thumbnail", count: 9)
      expect(page).to have_content("Accessory 3")
      expect(page).to have_content("49.99")
      expect(page).to have_xpath("//img[@src=\"/assets/accessories/soil.jpg\"]")
    end
  end
end
