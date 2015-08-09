require "rails_helper"

feature "user sees a single past order" do
  context "as an authenticated user with one previous order" do
    before do
      user = User.create(first_name: "Jane",
                         last_name:  "Doe",
                         email:      "jane@gmail.com",
                         password:   "password")

      @product_1 = Product.create(name:        "Plant1",
                                  description: "Plant 1 description",
                                  price:       9.99)

      @product_2 = Product.create(name:        "Plant2",
                                  description: "Plant 2 description",
                                  price:       19.99)

      @order = Order.create(user_id: user.id,
                            status: "Ordered",
                            created_at: DateTime.civil(2015, 07, 05, 21, 33, 0),
                            updated_at: DateTime.civil(2015, 07, 05, 21, 33, 0))

      OrderItem.create(order_id: @order.id,
                       product_id: @product_1.id,
                       quantity: 1,
                       unit_price: @product_1.price)

      OrderItem.create(order_id: @order.id,
                       product_id: @product_2.id,
                       quantity: 2,
                       unit_price: @product_2.price)

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(user)
    end
    scenario "user is able to see past order details" do
      visit orders_path

      expect(current_path).to eq(orders_path)

      within("td.order-details-link") do
        click_link("View Order Details")
      end

      expect(current_path).to eq(order_path(@order))

      expect(page).to have_content("Order ID: # #{@order.id}")
      expect(page).to have_content("Purchase Date/Time: July  5, 2015 at  9:33 PM")

      within("tr", text: "Plant1") do
        expect(page).to have_content("Plant1")
        expect(page).to have_content("1") # qty for Plant1
        expect(page).to have_content("$9.99") # subtotal
        save_and_open_page
        expect(page).to have_xpath("//a[@href=\"#{product_path(@product_1)}\"]")
      end

      within("tr", text: "Plant2") do
        expect(page).to have_content("Plant2")
        expect(page).to have_content("2") # qty for Plant2
        expect(page).to have_content("$39.98") # subtotal
        expect(page).to have_xpath("//a[@href=\"#{product_path(@product_2)}\"]")
      end

      expect(page).to have_content("Ordered", count: 2) # status
      expect(page).to have_content("$49.97") # total
    end
  end
end
