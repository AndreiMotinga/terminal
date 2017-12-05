require_relative "item"

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
    items.map { |i| Item.new(pricing_info, i[0], i[1]).total }
         .reduce(:+)
  end
end
