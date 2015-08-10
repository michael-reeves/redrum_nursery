require "rails_helper"
require "factory_helper"

feature "Admin can view all Products from Admin Dashboard" do
  before do
    admin = User.create(first_name: "Mike",
                      last_name: "Dorrance",
                      email: "mike@mike.com",
                      password: "12345678",
                      role: "admin")
    build_products

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(admin)

    visit admin_dashboard_path
  end

  scenario "admin logs in and sees View All Products button" do
    expect(page).to have_content("View All Products")
  end

  scenario "admin clicks on View All Products and sees all products" do
    product1 = @plants.products.first
    product2 = @food.products.first
    product3 = @accessories.products.first

    click_link "View All Products"

    expect(current_path).to eq(admin_products_path)
    expect(page).to have_content("All Products")
    expect(page).to have_content("Image")
    expect(page).to have_content("Name")
    expect(page).to have_content("Description")
    expect(page).to have_content("Price")
    expect(page).to have_content("Status")

    within("tr", text: product1.name) do
      expect(page).to have_css("img[src*='plants/plant-2.jpg']")
      expect(page).to have_content("Plant 1")
      expect(page).to have_content("This is the description for plant 1")
      expect(page).to have_content("19.99")
      expect(page).to have_content("active")
      expect(page).to have_link("edit")
    end
  end
end
