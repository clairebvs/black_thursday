require_relative "item_repository"
require_relative 'mathematics'
require_relative 'sales_analyst_helper'
require 'bigdecimal/util'

class SalesAnalyst
  include Mathematics
  include SalesAnalystHelper

  def initialize(parent)
    @parent = parent
  end

  def average_items_per_merchant
    data_set = @parent.items.merchant_id.values
    calculate_mean(elements_per_merchant(data_set)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    data_set = @parent.items.merchant_id.values
    standard_deviation(elements_per_merchant(data_set))
  end

  def merchants_with_high_item_count
    average_items = average_items_per_merchant
    standard_deviation = average_items_per_merchant_standard_deviation
    data_set = @parent.items.merchant_id.values
    items_sold = elements_per_merchant(data_set)
    merchant_ids = merchant_ids_with_high_item_count(items_sold, standard_deviation, average_items)
    transform_merchant_ids_to_names(merchant_ids)
  end

  def average_item_price_for_merchant(merchant_id)
    items = @parent.items.merchant_id[merchant_id.to_s]
    unit_prices = unit_prices_per_merchant(items)
    mean = calculate_mean(unit_prices)
    return_to_big_decimal(mean)
  end

  def average_average_price_per_merchant
    merchant_ids = @parent.items.merchant_id.keys
    sum = sum_of_merchant_item_price_averages(merchant_ids)
    average_average = sum / merchant_ids.length
    return_to_big_decimal(average_average)
  end

  def golden_items
    data_set = calculate_all_unit_prices
    average_price = average_price_per_unit(data_set)
    standard_deviation = standard_deviation(data_set)
    items_with_high_units_prices(data_set, standard_deviation, average_price)
  end

  def average_invoices_per_merchant
    data_set = @parent.invoices.merchant_id.values
    calculate_mean(elements_per_merchant(data_set)).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    data_set = @parent.invoices.merchant_id.values
    standard_deviation(elements_per_merchant(data_set))
  end

  def top_merchants_by_invoice_count
    average_invoices = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    data_set = @parent.invoices.merchant_id.values
    invoices_per_merchant = elements_per_merchant(data_set)
    merchant_ids = merchant_ids_with_high_invoice_count(invoices_per_merchant, standard_deviation, average_invoices)
    transform_merchant_ids_to_names(merchant_ids)
  end
end
