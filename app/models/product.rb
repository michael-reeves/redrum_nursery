class Product < ActiveRecord::Base
  belongs_to :category

  validates :name, :price, presence: true
end
