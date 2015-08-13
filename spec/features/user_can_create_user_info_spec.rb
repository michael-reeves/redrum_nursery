require "rails_helper"

feature "User can create User info" do
  before do
    visit root_path
    click_link "Create Account"
  end

  scenario "creates Login Info, Billing and Shipping Addresses" do
    find('input[type="text"][name*="user[first_name]"]').set("Jane")
    find('input[type="text"][name*="user[last_name]"]').set("Doe")
    find('input[type="text"][name*="user[email]"]').set("jane@doe.com")
    find('input[type="password"][name*="user[password]"]').set("password")
    click_button "Create Account"

    within(".alert-success") do
      expect(page).to have_content("Welcome to Redrum Nursery, Jane Doe!")
    end

    expect(page).to have_content("Jane Doe")
    expect(page).to have_content("jane@doe.com")

    click_link "Edit Account"
    click_link "Add Address"

    select "Billing", from: "address[type_of]"
    find('input[type="text"][name*="address[address_1]"]').set("1 Billing Address Way")
    find('input[type="text"][name*="address[address_2]"]').set("Unit 2")
    find('input[type="text"][name*="address[city]"]').set("Arlington")
    find('input[type="text"][name*="address[state]"]').set("TX")
    find('input[type="text"][name*="address[zip_code]"]').set("76014")
    click_button "Add Address"

    within(".alert-success") do
      expect(page).to have_content("Address created.")
    end

    within("#billing-info") do
      expect(find_field("address_address_1").value).to eq("1 Billing Address Way")
      expect(find_field("address_address_2").value).to eq("Unit 2")
      expect(find_field("address_city").value).to eq("Arlington")
      expect(find_field("address_state").value).to eq("TX")
      expect(find_field("address_zip_code").value).to eq("76014")
    end

    click_link "Add Addres"

    select "Shipping", from: "address[type_of]"
    find('input[type="text"][name*="address[address_1]"]').set("2 Shipping Address Pl")
    find('input[type="text"][name*="address[address_2]"]').set("#5")
    find('input[type="text"][name*="address[city]"]').set("Denver")
    find('input[type="text"][name*="address[state]"]').set("CO")
    find('input[type="text"][name*="address[zip_code]"]').set("80223")
    click_button "Add Address"

    within(".alert-success") do
      expect(page).to have_content("Address created.")
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
