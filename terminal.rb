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
    return count * pricing_info[name][:price] unless discount?(name)

    discount_count = pricing_info[name][:discount][:count]
    discount_price = pricing_info[name][:discount][:price]
    with_discount = (count / discount_count) * discount_price
    remainder = (count % discount_count) * pricing_info[name][:price]
    with_discount + remainder
  end

  def discount?(item_name)
    pricing_info[item_name][:discount]
  end
end
