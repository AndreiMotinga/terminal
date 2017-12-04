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
    regular_price = pricing_info[name][:price]
    return count * regular_price unless discount?(name)
    return count * pricing_info[name][:discounted_price] if apply_discounted?(name, count)

    discount = pricing_info[name][:discount]

    if discount && discount[:count]
      with_discount = (count / discount[:count]) * discount[:price]
      remainder = (count % discount[:count]) * regular_price
      with_discount + remainder
    else
      count * regular_price
    end
  end

  def discount?(item_name)
    pricing_info[item_name][:discount] || pricing_info[item_name][:discounted_price]
  end

  def apply_discounted?(name, count)
    return unless pricing_info[name][:discounted_price]
    return if count < pricing_info[name][:discounted_count]
    true
  end
end
