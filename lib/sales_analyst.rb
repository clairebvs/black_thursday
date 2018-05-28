require_relative "item_repository"
require_relative 'mathematics'

class SalesAnalyst
  include Mathematics

  def initialize(parent)
    @parent = parent
  end

  def items_per_merchant(data_set)
    data_set.map do |data|
      data.length
    end
  end

  def average_items_per_merchant
    data_set = @parent.items.merchant_id.values
    calculate_mean(items_per_merchant(data_set)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    data_set = @parent.items.merchant_id.values
    standard_deviation(items_per_merchant(data_set))
  end
end
