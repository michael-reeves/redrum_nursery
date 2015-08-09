class Cart
  attr_reader :data

  def initialize(data = {})
    @data = data || Hash.new
  end

  def cart_items
    @data.map do |product_id, quantity|
      product = Product.find(product_id)
      CartItem.new(product, quantity)
    end
  end

  def items
    @data.map do |product_id, _quantity|
      Product.find(product_id)
    end
  end

  def add_item(product)
    data[product.id.to_s] ||= 0
    data[product.id.to_s] +=  1
  end

  def update_item_quantity(product, quantity)
    data[product.id.to_s] = quantity
  end

  def delete_item(product)
    data.delete(product.id.to_s)
  end

  def total_price
    cart_items.reduce(0) do |total, cart_item|
      total + cart_item.item_total
    end
  end
end
