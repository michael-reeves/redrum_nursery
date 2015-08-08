require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) do
    User.new(first_name: "Jane",
             last_name:  "Doe",
             email:      "jane@doe.com",
             password:   "password")
  end

  it "creates a user" do
    user.save

    expect(User.all.first.first_name).to eq("Jane")
    expect(User.all.first.last_name).to eq("Doe")
    expect(User.all.first.email).to eq("jane@doe.com")
    expect(User.all.first.password_digest).to be_a(String)
  end

  it "has a first name" do
    user.first_name = nil

    expect(user).to be_invalid
  end

  it "has a last name" do
    user.last_name = nil

    expect(user).to be_invalid
  end

  it "has a email" do
    user.email = nil

    expect(user).to be_invalid
  end

  it "has a password" do
    user.password = nil

    expect(user).to be_invalid
  end

  it "has a unique email" do
    user.save
    user_2 = User.new(first_name: "John",
                      last_name:  "Doh",
                      email:      "jane@doe.com",
                      password:   "otherpassword")

    expect(user_2).to be_invalid
  end
end
