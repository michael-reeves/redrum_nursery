class Product < ActiveRecord::Base
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items

  before_validation :set_default_image
  validates :name, :description, :price, :category_id, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: { greater_than: 0 }

  enum status: %w(active inactive)

  scope :active, -> { where(status: 0) }
  scope :inactive, -> { where(status: 1) }

  private

  def set_default_image
    self.image_url = "default_image.jpg" if image_url && image_url.empty?
  end
end
