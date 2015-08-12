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
    @order_1 = Order.create(user_id: user.id,
                            status: "ordered",
                            created_at: DateTime.civil(2015, 07, 05, 21, 33, 0))

    @order_1.order_items.create(product_id: product.id,
                                quantity: 1,
                                unit_price: product.price)

    @order_2 = Order.create(user_id: user.id,
                            status: "paid",
                            created_at: DateTime.civil(2015, 07, 05, 21, 33, 0))

    @order_2.order_items.create(product_id: product.id,
                                quantity: 1,
                                unit_price: product.price)

    @order_3 = Order.create(user_id: user.id,
                            status: "cancelled",
                            created_at: DateTime.civil(2015, 07, 05, 21, 33, 0))

    @order_3.order_items.create(product_id: product.id,
                                quantity: 1,
                                unit_price: product.price)

    @order_4 = Order.create(user_id: user.id,
                            status: "completed",
                            created_at: DateTime.civil(2015, 07, 05, 21, 33, 0))

    @order_4.order_items.create(product_id: product.id,
                                quantity: 1,
                                unit_price: product.price)

    @order_5 = Order.create(user_id: user.id,
                            status: "completed",
                            created_at: DateTime.civil(2015, 07, 05, 21, 33, 0))


    @order_5.order_items.create(product_id: product.id,
                                quantity: 1,
                                unit_price: product.price)
  end

  scenario "and the the total number of orders for each status" do
    visit admin_dashboard_path

    expect(current_path).to eq(admin_dashboard_path)

    click_link("View All Orders")

    expect(current_path).to eq(admin_orders_path)

    within("li", text: "Ordered") do
      expect(page).to have_content("1")
    end

    within("li", text: "Paid") do
      expect(page).to have_content("1")
    end

    within("li", text: "Cancelled") do
      expect(page).to have_content("1")
    end

    within("li", text: "Completed") do
      expect(page).to have_content("2")
    end
  end

  scenario "and a link for each individual order" do
    visit admin_orders_path

    expect(current_path).to eq(admin_orders_path)

    within("tr", text: "# #{@order_1.id}") do
      # expect(page).to have_xpath("//a[@href=\"#{admin_order_path(@order_1)}\"]")
      expect(page).to have_content("Ordered")
      expect(page).to have_content("$9.99")
      expect(page).to have_content("July  5, 2015 at  9:33 PM")
    end

    within("tr", text: "# #{@order_2.id}") do
      # expect(page).to have_xpath("//a[@href=\"#{admin_order_path(@order_2)}\"]")
      expect(page).to have_content("Paid")
      expect(page).to have_content("$9.99")
      expect(page).to have_content("July  5, 2015 at  9:33 PM")
    end

    within("tr", text: "# #{@order_3.id}") do
      # expect(page).to have_xpath("//a[@href=\"#{admin_order_path(@order_3)}\"]")
      expect(page).to have_content("Cancelled")
      expect(page).to have_content("$9.99")
      expect(page).to have_content("July  5, 2015 at  9:33 PM")
    end

    within("tr", text: "# #{@order_4.id}") do
      # expect(page).to have_xpath("//a[@href=\"#{admin_order_path(@order_4)}\"]")
      expect(page).to have_content("Completed")
      expect(page).to have_content("$9.99")
      expect(page).to have_content("July  5, 2015 at  9:33 PM")
    end

    within("tr", text: "# #{@order_5.id}") do
      # expect(page).to have_xpath("//a[@href=\"#{admin_order_path(@order_5)}\"]")
      expect(page).to have_content("Completed")
      expect(page).to have_content("$9.99")
      expect(page).to have_content("July  5, 2015 at  9:33 PM")
    end

  end

  scenario "and admin can filter orders to display each status type" do
    visit admin_orders_path

    expect(current_path).to eq(admin_orders_path)

    click_link("Ordered 1")

    within("tr", text: "# #{@order_1.id}") do
      # expect(page).to have_xpath("//a[@href=\"#{admin_order_path(@order_1)}\"]")
      expect(page).to have_content("Ordered")
      expect(page).to have_content("$9.99")
      expect(page).to have_content("July  5, 2015 at  9:33 PM")
    end

    within("table .order-status") do
      expect(page).not_to have_content("Paid")
      expect(page).not_to have_content("Cancelled")
      expect(page).not_to have_content("Completed")
    end

    click_link("Paid 1")

    within("tr", text: "# #{@order_2.id}") do
      # expect(page).to have_xpath("//a[@href=\"#{admin_order_path(@order_1)}\"]")
      expect(page).to have_content("Paid")
      expect(page).to have_content("$9.99")
      expect(page).to have_content("July  5, 2015 at  9:33 PM")
    end

    within("table .order-status") do
      expect(page).not_to have_content("Ordered")
      expect(page).not_to have_content("Cancelled")
      expect(page).not_to have_content("Completed")
    end

    click_link("Cancelled 1")

    within("tr", text: "# #{@order_3.id}") do
      # expect(page).to have_xpath("//a[@href=\"#{admin_order_path(@order_1)}\"]")
      expect(page).to have_content("Cancelled")
      expect(page).to have_content("$9.99")
      expect(page).to have_content("July  5, 2015 at  9:33 PM")
    end

    within("table .order-status") do
      expect(page).not_to have_content("Ordered")
      expect(page).not_to have_content("Paid")
      expect(page).not_to have_content("Completed")
    end

    click_link("Completed 2")

    within("tr", text: "# #{@order_4.id}") do
      # expect(page).to have_xpath("//a[@href=\"#{admin_order_path(@order_1)}\"]")
      expect(page).to have_content("Completed")
      expect(page).to have_content("$9.99")
      expect(page).to have_content("July  5, 2015 at  9:33 PM")
    end

    status = find("table").first(".order-status").text
      expect(status).not_to eq("Ordered")
      expect(status).not_to eq("Paid")
      expect(status).not_to eq("Cancelled")
  end

  scenario "and there are links to transition the status" do
    visit admin_orders_path

    expect(current_path).to eq(admin_orders_path)

    within("tr", text: "# #{@order_1.id}") do
      expect(page).to have_link("Cancel")
      expect(page).to have_link("Paid")
    end

    within("tr", text: "# #{@order_2.id}") do
      expect(page).to have_link("Cancel")
      expect(page).to have_link("Completed")
    end

    within("tr", text: "# #{@order_3.id}") do
      expect(page).to_not have_link("Ordered")
      expect(page).to_not have_link("Paid")
      expect(page).to_not have_link("Completed")
    end

     within("tr", text: "# #{@order_4.id}") do
      expect(page).to_not have_link("Ordered")
      expect(page).to_not have_link("Paid")
      expect(page).to_not have_link("Cancel")
    end
  end

  scenario "and the status of the orders can be changed" do
    visit admin_orders_path

    within("tr", text: "# #{@order_1.id}") do
      click_link("Paid")
    end

    within("li", text: "Paid") do
      expect(page).to have_content("2")
    end

    within("tr", text: "# #{@order_2.id}") do
      click_link("Completed")
    end

    within("li", text: "Completed") do
      expect(page).to have_content("3")
    end

    within("tr", text: "# #{@order_1.id}") do
      click_link("Cancelled")
    end

    within("li", text: "Cancelled") do
      expect(page).to have_content("2")
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
