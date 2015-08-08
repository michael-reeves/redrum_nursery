require "rails_helper"

feature "Admin can view Admin Dashboard" do
  scenario "Admin logs in and sees Admin Dashboard for /admin/dashboard" do
    User.create(first_name: "Admin",
                        last_name: "Admin",
                        email: "admin@admin.com",
                        password: "password",
                        role: 1)

    visit "/login"

    fill_in "Email", with: "admin@admin.com"
    fill_in "Password", with: "password"
    click_button "Login"

    visit "/admin/dashboard"

    expect(current_path).to eq("/admin/dashboard")
    expect(page).to have_content("Admin Dashboard")
  end

  scenario "Non-admin logs in and sees 404 page for /admin/dashboard" do
    User.create(first_name: "Jane",
                        last_name: "Doe",
                        email: "jane@doe.com",
                        password: "password",
                        role: 0)

    visit "/login"

    fill_in "Email", with: "jane@doe.com"
    fill_in "Password", with: "password"
    click_button "Login"

    visit "/admin/dashboard"

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario "Non-user sees 404 page for /admin/dashboard" do
    visit "/admin/dashboard"

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
