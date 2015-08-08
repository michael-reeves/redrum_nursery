class User < ActiveRecord::Base
  has_secure_password

  before_validation :strip_whitespace
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :password, length: { minimum: 8 }

  private

  def strip_whitespace
    self.first_name = self.first_name.strip if self.first_name
    self.last_name = self.last_name.strip if self.last_name
    self.email = self.email.strip if self.email
  end
end
