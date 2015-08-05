require "rails_helper"

feature "a visitor" do
  context "visits /products/:id" do
    scenario "and sees product details" do 
      product = Product.create(name: "Plant 1",
                               description: "This is the description for plant 1",
                               price: 19.99)

      visit product_path(product)      

      expect(page).to have_content("Plant 1")
      expect(page).to have_content("This is the description for plant 1")
      expect(page).to have_content("19.99")
      within(".caption-full") do
        expect(page).to have_content("Add to Cart")
      end
    end
  end
end
