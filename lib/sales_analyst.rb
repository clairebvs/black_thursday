# require_relative "merchant_repository"
require_relative "item_repository"

class SalesAnalyst
  include Mathematics

  def initialize(parent)
    @parent = parent
  end

  def find_number_of_merchants
    @parent.items.merchant_id.keys.length
  end

  def average_items_per_merchant
    (@parent.items.all.length / find_number_of_merchants.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation

  end
end
