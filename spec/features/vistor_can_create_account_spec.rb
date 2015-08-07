require "rails_helper"

feature "a visitor can create an account" do
  scenario "a visitor clicks on the create account button and" \
    " sees create account form" do
    visit "/"
    click_link "Create Account"

    expect(current_path).to eq(new_user_path)
    expect(page).to have_content("First Name")
    expect(page).to have_content("Last Name")
    expect(page).to have_content("Username")
    expect(page).to have_content("Password")
    expect(page).to have_button("Create Account")
  end
end
