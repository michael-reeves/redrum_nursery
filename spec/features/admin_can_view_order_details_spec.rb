require "rails_helper"
require "factory_helper"

feature "admin user" do
  scenario "can view individual orders" do
    category = Category.create(
      name: "Plants",
      description: "Carnivorous plants!"
    )

    plant1 = category.products.create(name: "Plant 1",
                        description: "This is the description for plant 1",
                        price: 19.99,
                        image_url: "plants/plant-2.jpg",
                        status: "active")
    plant2 = category.products.create(name: "Plant 2",
                        description: "This is the description for plant 2",
                        price: 29.99,
                        image_url: "plants/plant-2.jpg",
                        status: "active")

    user = User.create(first_name: "Jane",
                       last_name:  "Doe",
                       email: "jane@doe.com",
                       password: "password")

    order = user.orders.create(status: 0)
    order.order_items.create(product_id: plant1.id,
                             quantity:   3,
                             unit_price: plant1.price)
    order.order_items.create(product_id: plant2.id,
                             quantity:   1,
                             unit_price: plant2.price)


    admin = User.create(first_name: "Mike",
                        last_name: "D",
                        email: "mike@mike.com",
                        password: "12345678",
                        role: "admin")

    allow_any_instance_of(ApplicationController).to receive(
      :current_user).and_return(admin)

    visit admin_order_path(order)

    expect(current_path).to eq(admin_order_path(order))
# byebug

    within("tr", text: "Plant 1") do
      expect(page).to have_content("ordered")
      expect(page).to have_content("3")
      expect(page).to have_content("$19.99")
      expect(page).to have_content("$59.97")
    end
    within("tr", text: "Plant 2") do
      expect(page).to have_content("ordered")
      expect(page).to have_content("1")
      expect(page).to have_content("$29.99")
    end

    expect(page).to have_content("$89.96")
  end
end
