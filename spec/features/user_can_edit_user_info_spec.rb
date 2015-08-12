require "rails_helper"

feature "User can edit User info" do
  before do
    user = User.create(first_name: "Jane",
                       last_name:  "Doe",
                       email:      "jane@doe.com",
                       password:   "password")

    user.addresses.create(type_of:   0,
                          address_1: "1313 Mockingbird Ln",
                          address_2: "Ste 13",
                          city:      "Walla Walla",
                          state:     "PA",
                          zip_code:  "13131")

    user.addresses.create(type_of:   1,
                          address_1: "123 Sesame St",
                          address_2: "Apt 123",
                          city:      "New York",
                          state:     "NY",
                          zip_code:  "12345")

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)
  end

  scenario "User can view edit form and update account" do
    pending

    visit dashboard_path
    click_link "Edit Account"

    expect(find_field("user_first_name").value).to eq("Jane")
    expect(find_field("user_last_name").value).to eq("Doe")
    expect(find_field("user_email").value).to eq("jane@doe.com")
    expect(find_field("billing_address_1").value).to eq("1313 Mockingbird Ln")
    expect(find_field("billing_address_2").value).to eq("Ste 13")
    expect(find_field("billing_city").value).to eq("Walla Walla")
    expect(find_field("billing_state").value).to eq("PA")
    expect(find_field("billing_zip_code").value).to eq("13131")
    expect(find_field("shipping_address_1").value).to eq("123 Sesame St")
    expect(find_field("shipping_address_2").value).to eq("Apt 123")
    expect(find_field("shipping_city").value).to eq("New York")
    expect(find_field("shipping_state").value).to eq("NY")
    expect(find_field("shipping_zip_code").value).to eq("12345")

    within("#billing-info") do
      find('input[type="text"][name*="billing[address_1]"]').set("1 Billing Address Way")
      find('input[type="text"][name*="billing[address_2]"]').set("Unit 2")
      find('input[type="text"][name*="billing[city]"]').set("Arlington")
      find('input[type="text"][name*="billing[state]"]').set("TX")
      find('input[type="text"][name*="billing[zip_code]"]').set("76014")
    end

    within("#shipping-info") do
      find('input[type="text"][name*="shipping[address_1]"]').set("2 Shipping Address Pl")
      find('input[type="text"][name*="shipping[address_2]"]').set("#5")
      find('input[type="text"][name*="shipping[city]"]').set("Denver")
      find('input[type="text"][name*="shipping[state]"]').set("CO")
      find('input[type="text"][name*="shipping[zip_code]"]').set("80223")
    end

    within("#login-info") do
      find('input[type="text"][name*="user[first_name]"]').set("John")
      find('input[type="text"][name*="user[last_name]"]').set("Doh")
      find('input[type="text"][name*="user[email]"]').set("john@doh.com")
      find('input[type="password"][name*="user[password]"]').set("password")
      click_button "Update Account"
    end

    within(".alert-success") do
      expect(page).to have_content("Your account has been updated.")
    end

    expect(page).to have_content("John Doh")
    expect(page).to have_content("john@doh.com")

    within("#billing-address") do
      expect(page).to have_content("1 Billing Address Way")
      expect(page).to have_content("Unit 2")
      expect(page).to have_content("Arlington")
      expect(page).to have_content("TX")
      expect(page).to have_content("76014")
    end

    within("#shipping-address") do
      expect(page).to have_content("2 Shipping Address Pl")
      expect(page).to have_content("#5")
      expect(page).to have_content("Denver")
      expect(page).to have_content("CO")
      expect(page).to have_content("80223")
    end
  end
end
