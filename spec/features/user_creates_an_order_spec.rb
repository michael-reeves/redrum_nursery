require "rails_helper"

feature "Existing user places an order" do
  context "logged in user and a cart with products" do
    before do
      user = User.create(first_name: "Jane",
                         last_name:  "Doe",
                         email:      "jane@gmail.com",
                         password:   "password")

      product_1 = Product.create(name:        "Plant1",
                                 description: "Plant 1 description",
                                 price:       9.99)

      product_2 = Product.create(name:        "Plant2",
                                 description: "Plant 2 description",
                                 price:       19.99)

      cart = Cart.new(nil)
      cart.add_item(product_1)
      cart.add_item(product_2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(ApplicationController).to receive(:cart).and_return(cart)
    end

    scenario "successfully places an order for two different products" do
      visit cart_path
      click_button "Checkout"

      expect(curent_path).to eq(orders_path)
      expect(page).to have_content("Ordered")
      expect(page).to have_content("$39.98")
    end
  end
end
  
