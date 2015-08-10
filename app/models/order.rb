class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  enum status: ["ordered", "paid", "cancelled", "completed"]
  validates :status,
    inclusion: { in: ["ordered", "paid", "cancelled", "completed"] }

  def total
    order_items.inject(0) do |total, order_item|
      total += (order_item.quantity * order_item.unit_price)
    end
  end
end
