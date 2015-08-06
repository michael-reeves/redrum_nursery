class Category < ActiveRecord::Base
  has_many :products

  before_validation :add_slug
  validates :name, presence: true
  validates :slug, length: { minimum: 3 }

  protected

  def add_slug
    self.slug = "#{name}".parameterize if name
  end
end
