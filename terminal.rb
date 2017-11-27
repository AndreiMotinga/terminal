class Terminal

  attr_reader :pricing_info, :items
  def initialize(pricing_info)
    @pricing_info = pricing_info
    @items = Hash.new(0)
  end

  def scan(item)
    items[item.to_sym] += 1
  end

  def total
    items.map { |i| item_total(i) }.reduce(:+)
  end

  private

  def item_total(item)
    name, count = item
    return count * pricing_info[name][:price] unless discounts?(name)

    discount_count = pricing_info[name][:discounts].first[:count]
    discount_price = pricing_info[name][:discounts].first[:price]
    with_discounts = (count / discount_count) * discount_price
    remainder = (count % discount_count) * pricing_info[name][:price]
    with_discounts + remainder
  end

  def discounts?(item_name)
    pricing_info[item_name][:discounts].any?
  end
end
