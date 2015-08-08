class User < ActiveRecord::Base
  has_secure_password
  has_many :orders

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
end
