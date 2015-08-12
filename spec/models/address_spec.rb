require "rails_helper"

RSpec.describe Address, type: :model do
  let(:user) do
    User.create(first_name: "Jane",
                last_name:  "Doe",
                email:      "jane@doe.com",
                password:   "password")
  end

  let(:billing_address) do
    user.addresses.new(type_of:   "billing",
                       address_1: "1313 Mockingbird Ln",
                       address_2: "Ste 13",
                       city:      "Walla Walla",
                       state:     "PA",
                       zip_code:  "13131")
  end

  let(:shipping_address) do
    user.addresses.new(type_of:   "shipping",
                       address_1: "123 Sesame St",
                       address_2: "Apt 123",
                       city:      "New York",
                       state:     "NY",
                       zip_code:  "12345")
  end

  it "creates a billing address" do
    expect(billing_address.type_of).to eq("billing")
    expect(billing_address.address_1).to eq("1313 Mockingbird Ln")
    expect(billing_address.address_2).to eq("Ste 13")
    expect(billing_address.city).to eq("Walla Walla")
    expect(billing_address.state).to eq("PA")
    expect(billing_address.zip_code).to eq("13131")
  end

  it "creates a shipping address" do
    expect(shipping_address.type_of).to eq("shipping")
    expect(shipping_address.address_1).to eq("123 Sesame St")
    expect(shipping_address.address_2).to eq("Apt 123")
    expect(shipping_address.city).to eq("New York")
    expect(shipping_address.state).to eq("NY")
    expect(shipping_address.zip_code).to eq("12345")
  end

  it "belongs to a user" do
    expect(billing_address.user_id).to eq(user.id)
    expect(shipping_address.user_id).to eq(user.id)
  end

  it "has an address_1" do
    billing_address.address_1 = nil

    expect(billing_address).to_not be_valid
  end

  it "has a city" do
    billing_address.city = nil

    expect(billing_address).to_not be_valid
  end

  it "has a state" do
    billing_address.state = nil

    expect(billing_address).to_not be_valid
  end

  it "has a zip_code" do
    billing_address.zip_code = nil

    expect(billing_address).to_not be_valid
  end

  it "has a numeric zip_code" do
    billing_address.zip_code = "abcde"

    expect(billing_address).to_not be_valid
  end

  it "has a zip_code length of 5-9" do
    billing_address.zip_code = 1234
    expect(billing_address).to_not be_valid

    billing_address.zip_code = 1234567890
    expect(billing_address).to_not be_valid

    billing_address.zip_code = 12345
    expect(billing_address).to be_valid

    billing_address.zip_code = 123456789
    expect(billing_address).to be_valid
  end

  it "strips whitespace for all text columns" do
    address = Address.create(address_1: " Address 1 ",
                             address_2: " Address 2 ",
                             city:      " City ",
                             state:     " ST ",
                             zip_code:  " 12345 ")

    expect(address.address_1).to eq("Address 1")
    expect(address.address_2).to eq("Address 2")
    expect(address.city).to eq("City")
    expect(address.state).to eq("ST")
    expect(address.zip_code).to eq("12345")
  end
end
