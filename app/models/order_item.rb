class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  validates :quantity, numericality: { greater_than: 0 }

  def subtotal
    unit_price * quantity
  end
end
