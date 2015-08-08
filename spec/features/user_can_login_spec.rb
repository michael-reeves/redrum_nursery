require "rails_helper"

feature "a user can login" do
  scenario "an existing user logs in" do
    User.create(first_name: "Jane",
                last_name: "Doe",
                email: "jane@doe.com",
                password: "12345678")

    visit "/"
    click_link "Login"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Welcome Back to Redrum Nursery!")
    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
    expect(page).to have_button("Login")

    fill_in "Email", with: "jane@doe.com"
    fill_in "Password", with: "12345678"
    click_button "Login"

    expect(current_path).to eq(dashboard_path)
    within(".alert-success") do
      expect(page).to have_content("Welcome back to Redrum Nursery, Jane Doe!")
    end
    within(".navbar-right") do
      expect(page).to have_content("Logged in as Jane Doe")
    end
    expect(page).to have_content("Jane")
    expect(page).to have_content("Doe")
    expect(page).to have_content("jane@doe.com")
    expect(page).to_not have_content("Login")
    expect(page).to have_content("Logout")
  end

  scenario "a visitor without an account can not login" do
    visit "/"
    click_link "Login"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Welcome Back to Redrum Nursery!")
    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
    expect(page).to have_button("Login")

    fill_in "Email", with: "jane@doe.com"
    fill_in "Password", with: "12345678"
    click_button "Login"

    expect(current_path).to eq(login_path)
    within(".alert-warning") do
      expect(page).to have_content("Unable to Login with this Email and" \
        " Password combination.")
    end
    within(".navbar-right") do
      expect(page).to_not have_content("Logged in as Jane Doe")
    end
    expect(page).to_not have_content("Jane")
    expect(page).to_not have_content("Doe")
    expect(page).to_not have_content("jane@doe.com")
    expect(page).to have_content("Create Account")
    expect(page).to have_content("Login")
  end
end
