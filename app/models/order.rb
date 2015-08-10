class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items

  def total
    order_items.reduce(0) do |total, order_item|
      total + (order_item.quantity * order_item.unit_price)
    end
  end
end
