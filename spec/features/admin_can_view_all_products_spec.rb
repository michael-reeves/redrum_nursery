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

  scenario "Admin logs in and sees View All Products button" do
    expect(page).to have_content("View All Products")
  end

  scenario "Admin clicks on View All Products and sees all products" do
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
    expect(page).to have_content("Category")
    expect(page).to have_content("Status")

    within("tr", text: product1.name) do
      expect(page).to have_css("img[src*='plants/plant-2.jpg']")
      expect(page).to have_content("Plant 1")
      expect(page).to have_content("This is the description for plant 1")
      expect(page).to have_content("19.99")
      expect(page).to have_content("Plants")
      expect(page).to have_content("active")
      expect(page).to have_link("edit")
    end
  end
  scenario "Admin clicks on edit button and can edit that Product" do
    product1 = @plants.products.first

    click_link "View All Products"

    within("tr", text: product1.name) do
      expect(page).to have_css("img[src*='plants/plant-2.jpg']")
      expect(page).to have_content("Plant 1")
      expect(page).to have_content("This is the description for plant 1")
      expect(page).to have_content("19.99")
      expect(page).to have_content("Plants")
      expect(page).to have_content("active")
      expect(page).to have_link("edit")

      click_link "edit"
    end

      expect(current_path).to eq(edit_admin_product_path(product1))
      expect(page).to have_content("Edit Product")
      expect(page).to have_content("Name")

      name = find("#product_form_name").value
      expect(name).to eq("Plant 1")

      description = find("#product_form_description").value
      expect(description).to eq("This is the description for plant 1")
      expect(page).to have_content("Price")
      price = find("#product_form_price").value
      expect(price).to eq("19.99")
      expect(page).to have_content("Status")
      status = find("#product_form_status").value
      category = find("#product_form_category").value
      expect(page).to have_content("Plants")
      expect(page).to have_content("Active")
      expect(page).to have_content("Image Url")
      url = find("#product_form_image_url").value
      expect(url).to eq("plants/plant-2.jpg")
      expect(page).to have_button("Edit Product")

      find('input[type="text"][name*="name"]').set("Richard")
      find('input[type="text"][name*="description"]').set("A boat.")
      find('input[type="text"][name*="price"]').set("12.99")
      find('input[type="text"][name*="image_url"]').set("")
      select "Food", from: "product[category_id]"
      select "Retired", from: "product[status]"
      click_button "Edit Product"

      expect(current_path).to eq(admin_products_path)
      within("tr", text: "Richard") do
      expect(page).to have_css("img[src*='default_image.jpg']")
      expect(page).to have_content("Richard")
      expect(page).to have_content("A boat.")
      expect(page).to have_content("12.99")
      expect(page).to have_content("Food")
      expect(page).to have_content("inactive")
      expect(page).to have_link("edit")
    end
  end
end
