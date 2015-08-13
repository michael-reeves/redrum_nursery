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

    visit dashboard_path
    click_link "Edit Account"
  end

  scenario "views edit form and updates Login Info" do
    within("#login-info") do
      expect(find_field("user_first_name").value).to eq("Jane")
      expect(find_field("user_last_name").value).to eq("Doe")
      expect(find_field("user_email").value).to eq("jane@doe.com")
    end

    within("#billing-info") do
      expect(find_field("address_address_1").value).to eq("1313 Mockingbird Ln")
      expect(find_field("address_address_2").value).to eq("Ste 13")
      expect(find_field("address_city").value).to eq("Walla Walla")
      expect(find_field("address_state").value).to eq("PA")
      expect(find_field("address_zip_code").value).to eq("13131")
    end

    within("#shipping-info") do
      expect(find_field("address_address_1").value).to eq("123 Sesame St")
      expect(find_field("address_address_2").value).to eq("Apt 123")
      expect(find_field("address_city").value).to eq("New York")
      expect(find_field("address_state").value).to eq("NY")
      expect(find_field("address_zip_code").value).to eq("12345")
    end
  end

  scenario "updates Login Info" do
    within("#login-info") do
      find('input[type="text"][name*="user[first_name]"]').set("John")
      find('input[type="text"][name*="user[last_name]"]').set("Doh")
      find('input[type="text"][name*="user[email]"]').set("john@doh.com")
      find('input[type="password"][name*="user[password]"]').set("password")
      click_button "Update Login Info"
    end

    within(".alert-success") do
      expect(page).to have_content("Your account has been updated.")
    end

    expect(find_field("user_first_name").value).to eq("John")
    expect(find_field("user_last_name").value).to eq("Doh")
    expect(find_field("user_email").value).to eq("john@doh.com")
  end

  scenario "updates Billing Address" do
    within("#billing-info") do
      find('input[type="text"][name*="address[address_1]"]').set("1 Billing Address Way")
      find('input[type="text"][name*="address[address_2]"]').set("Unit 2")
      find('input[type="text"][name*="address[city]"]').set("Arlington")
      find('input[type="text"][name*="address[state]"]').set("TX")
      find('input[type="text"][name*="address[zip_code]"]').set("76014")
      click_button "Update Billing Address"
    end

    within(".alert-success") do
      expect(page).to have_content("Your address has been updated.")
    end

    within("#billing-info") do
      expect(find_field("address_address_1").value).to eq("1 Billing Address Way")
      expect(find_field("address_address_2").value).to eq("Unit 2")
      expect(find_field("address_city").value).to eq("Arlington")
      expect(find_field("address_state").value).to eq("TX")
      expect(find_field("address_zip_code").value).to eq("76014")
    end
  end

  scenario "updates Shipping Address" do
    within("#shipping-info") do
      find('input[type="text"][name*="address[address_1]"]').set("2 Shipping Address Pl")
      find('input[type="text"][name*="address[address_2]"]').set("#5")
      find('input[type="text"][name*="address[city]"]').set("Denver")
      find('input[type="text"][name*="address[state]"]').set("CO")
      find('input[type="text"][name*="address[zip_code]"]').set("80223")
      click_button "Update Shipping Address"
    end

    within(".alert-success") do
      expect(page).to have_content("Your address has been updated.")
    end

    within("#shipping-info") do
      expect(find_field("address_address_1").value).to eq("2 Shipping Address Pl")
      expect(find_field("address_address_2").value).to eq("#5")
      expect(find_field("address_city").value).to eq("Denver")
      expect(find_field("address_state").value).to eq("CO")
      expect(find_field("address_zip_code").value).to eq("80223")
    end
  end
end
