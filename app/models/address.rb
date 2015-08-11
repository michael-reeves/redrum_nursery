class Address < ActiveRecord::Base
  belongs_to :user

  before_validation :strip_whitespace
  validates :address_1, :city, :state, :zip_code, presence: true
  validates :zip_code, numericality: true, length: 5..9

  enum type_of: %w(billing shipping)

  private

  def strip_whitespace
    self.address_1 = address_1.strip if address_1
    self.address_2 = address_2.strip if address_2
    self.city = city.strip if city
    self.state = state.strip if state
    self.zip_code = zip_code.strip if zip_code
  end
end
