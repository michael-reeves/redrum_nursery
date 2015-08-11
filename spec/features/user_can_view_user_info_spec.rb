require "rails_helper"

feature "User can view User info" do
  before do
    user = User.create(first_name: "Jane",
                       last_name:  "Doe",
                       email:      "jane@doe.com",
                       password:   "password")

    user.addresses.create(type_of:   "billing",
                          address_1: "1313 Mockingbird Ln",
                          address_2: "Ste 13",
                          city:      "Walla Walla",
                          state:     "PA",
                          zip_code:  "13131")

    user.addresses.create(type_of:   "shipping",
                          address_1: "123 Sesame St",
                          address_2: "Apt 123",
                          city:      "New York",
                          state:     "NY",
                          zip_code:  "12345")
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)
  end

  scenario "User visits Dashboard and sees all User info" do
    visit dashboard_path

    expect(page).to have_content("Jane")
    expect(page).to have_content("Doe")
    expect(page).to have_content("jane@doe.com")

    within("#billing-address") do
      expect(page).to have_content("1313 Mockingbird Ln")
      expect(page).to have_content("Ste 13")
      expect(page).to have_content("Walla Walla")
      expect(page).to have_content("PA")
      expect(page).to have_content("13131")
    end

    within("#shipping-address") do
      expect(page).to have_content("123 Sesame St")
      expect(page).to have_content("Apt 123")
      expect(page).to have_content("New York")
      expect(page).to have_content("NY")
      expect(page).to have_content("12345")
    end
  end
end
