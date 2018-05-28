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

  def merchant_ids_with_high_item_count(items_sold, standard_deviation, average_items)
    items_sold.map.with_index do |num_of_items, index|
      if (num_of_items - standard_deviation - average_items).positive?
        @parent.items.merchant_id.keys[index].to_i
      end
    end.compact
  end

  def transform_merchant_ids_to_names(merchant_ids)
    merchant_ids.map do |id|
      @parent.merchants.id[id].first
    end
  end

  def merchants_with_high_item_count
    average_items = average_items_per_merchant_standard_deviation
    standard_deviation = average_items_per_merchant_standard_deviation
    data_set = @parent.items.merchant_id.values
    items_sold = items_per_merchant(data_set)
    merchant_ids = merchant_ids_with_high_item_count(items_sold, standard_deviation, average_items)
    transform_merchant_ids_to_names(merchant_ids)
  end
end
