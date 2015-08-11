class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_many :addresses

  before_validation :strip_whitespace
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :password, length: { minimum: 8 }

  enum role: %w(default admin)

  def full_name
    "#{first_name} #{last_name}"
  end
  private

  def strip_whitespace
    self.first_name = first_name.strip if first_name
    self.last_name = last_name.strip if last_name
    self.email = email.strip if email
  end
end
