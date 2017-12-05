class Item

  attr_reader :pricing_info, :name, :count
  def initialize(pricing_info, item)
    @pricing_info = pricing_info
    @name = item[0]
    @count = item[1]
  end

  def total
    return count * discounted_price if use_discounted_price?
    return with_batch_discount if apply_batch_discount?
    count * base_price
  end

  private

  def with_batch_discount
    with_discount = (count / batch_discount[:count]) * batch_discount[:price]
    remainder = (count % batch_discount[:count]) * base_price
    with_discount + remainder
  end

  def use_discounted_price?
    return unless discounted_price
    return if count < pricing_info[name][:discounted_count]
    true
  end

  def discounted_price
    pricing_info[name][:discounted_price]
  end

  def apply_batch_discount?
    !batch_discount.nil?
  end

  def base_price
    pricing_info[name][:price]
  end

  def batch_discount
    pricing_info[name][:batch_discount]
  end
end
