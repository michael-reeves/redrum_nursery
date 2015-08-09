require "rails_helper"

feature "an admin can create products" do
  before do
    User.create(first_name: "Mike",
                last_name: "Dorrance",
                email: "mike@mike.com",
                password: "12345678",
                role: 1)

    visit "/"
    click_link "Login"
    fill_in "Email", with: "mike@mike.com"
    fill_in "Password", with: "12345678"
    click_button "Login"

    visit "/admin/dashboard"

    Category.create(name: "Plants",
                    description: "osidfg",
                    slug: "category")
    Category.create(name: "Food",
                    description: "osidfasdfg",
                    slug: "category")

    click_link "Add Product"
  end

  scenario "admin clicks Add Product and sees Add Product Page" do
    expect(current_path).to eq(new_admin_product_path)
    expect(page).to have_content("Add a New Product")
    expect(page).to have_content("Name")
    expect(page).to have_content("Description")
    expect(page).to have_content("Price")
    expect(page).to have_content("Category")
    expect(page).to have_content("Image Url")
    expect(page).to have_button("Add Product")
  end

  scenario "admin can create a new Product" do


    fill_in "Name", with: "Richard Plant"
    fill_in "Description", with: "A boat on a lot."
    fill_in "Price", with: "12.99"
    select "Plants", from: "category[category_id]"
    fill_in "Image Url", with: "image_url"
    click_button "Add Product"

    expect(current_path).to (admin_dashboard_path)
    within(".alert-success") do
      endexpect(page).to have_content("Richard Plant has been added.")
    end
  end
end
