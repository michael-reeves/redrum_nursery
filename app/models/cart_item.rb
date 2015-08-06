class CartItem < SimpleDelegator
  attr_reader :quantity

  def initialize(product, quantity = 0)
    super(product)
    @quantity = quantity
  end

  def item_total
    quantity * price
  end
end
