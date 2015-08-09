class Product < ActiveRecord::Base
  belongs_to :category

  validates :name, :description, :price, :category_id, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: { greater_than: 0 }
end
