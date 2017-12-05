class Item

  attr_reader :pricing_info, :item
  def initialize(pricing_info, item)
    @pricing_info = pricing_info
    @item = item
  end

  def total
    name, count = item
    regular_price = pricing_info[name][:price]
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
