require "rails_helper"

feature "admin can see all orders" do
  before do
    admin = User.create(first_name: "Jane",
                        last_name:  "Doe",
                        email:      "jane@gmail.com",
                        password:   "password",
                        role:       1)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(admin)

    user = User.create(first_name: "Jane",
                       last_name:  "Doe",
                       email:      "jane@gmail.com",
                       password:   "password")

    category = Category.create(name: "Plants",
                               description: "Plants category description",
                               slug: "plants")

    product = category.products.create(name:        "Plant1",
                                       description: "Plant 1 description",
                                       price:       9.99)
    order_1 = Order.create(user_id: user.id,
                           status: "ordered")

    order_1.order_items.create(product_id: product.id,
                               quantity: 1,
                               unit_price: product.price)

    order_2 = Order.create(user_id: user.id,
                           status: "paid")

    order_2.order_items.create(product_id: product.id,
                               quantity: 1,
                               unit_price: product.price)

    order_3 = Order.create(user_id: user.id,
                           status: "cancelled")

    order_3.order_items.create(product_id: product.id,
                               quantity: 1,
                               unit_price: product.price)

    order_4 = Order.create(user_id: user.id,
                           status: "completed")

    order_4.order_items.create(product_id: product.id,
                               quantity: 1,
                               unit_price: product.price)
  end

  scenario "and the the total number of orders for each status" do
    visit admin_dashboard_path

    expect(current_path).to eq(admin_dashboard_path)

    click_link("View All Orders")

    expect(current_path).to eq(admin_orders_path)

    within("tr", text: "Ordered") do
      expect(page).to have_content("1")
    end

    within("tr", text: "Paid") do
      expect(page).to have_content("1")
    end

    within("tr", text: "Cancelled") do
      expect(page).to have_content("1")
    end

    within("tr", text: "Completed") do
      expect(page).to have_content("1")
    end
  end
end


# As an Admin
# When I visit the dashboard
# Then I can see a link to a listing of all orders
# And I can see the total number of orders for each status ("Ordered", "Paid", "Cancelled", "Completed")
# And I can see a link for each individual order
# And I can filter orders to display by each status type  ("Ordered", "Paid", "Cancelled", "Completed")
# And I have links to transition the status
# 
# I can click on "cancel" on individual orders which are "paid" or "ordered"
# I can click on "mark as paid" on orders that are "ordered"
# I can click on "mark as completed" on orders that are "paid"
