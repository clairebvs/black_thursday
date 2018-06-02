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
    data_set = @parent.items.merchant_id.values
    average_items = average_items_per_merchant
    standard_deviation = average_items_per_merchant_standard_deviation
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
    data_set = @parent.invoices.merchant_id.values
    average_invoices = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    invoices_per_merchant = elements_per_merchant(data_set)
    merchant_ids = merchant_ids_with_high_invoice_count(invoices_per_merchant, standard_deviation, average_invoices)
    transform_merchant_ids_to_names(merchant_ids)
  end

  def bottom_merchants_by_invoice_count
    data_set = @parent.invoices.merchant_id.values
    average_invoices = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    invoices_per_merchant = elements_per_merchant(data_set)
    merchant_ids = merchant_ids_with_low_invoice_count(invoices_per_merchant, standard_deviation, average_invoices)
    transform_merchant_ids_to_names(merchant_ids)
  end

  def top_days_by_invoice_count
    all_invoices = @parent.invoices.all
    days_of_week = days_of_week_per_invoice(all_invoices)
    group_days_of_week = days_of_week.values
    invoices_per_day = invoices_per_day_of_week(group_days_of_week)
    average_invoices = calculate_mean(invoices_per_day).round(2)
    standard_deviation = standard_deviation(invoices_per_day)
    days_with_high_invoice_count(days_of_week, invoices_per_day, standard_deviation, average_invoices)
  end

  def invoice_status(status)
    all_status = @parent.invoices.status[status]
    count_status = all_status.length
    count_all = @parent.invoices.all.length
    find_percentage(count_status, count_all)
  end

  def invoice_paid_in_full?(invoice_id)
    successful_transaction = @parent.transactions.result[:success]
    successful_transaction.any? do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def invoice_total(invoice_id)
    if invoice_paid_in_full?(invoice_id)
      invoice_items_with_invoice_id = @parent.invoice_items.find_all_by_invoice_id(invoice_id)
      invoice_item_totals(invoice_items_with_invoice_id)
    end
  end

  def top_buyers(top_customers = 20)
    customer_ids = @parent.invoices.customer_id.keys
    customer_invoices = @parent.invoices.customer_id.values
    customer_totals = calculate_totals_per_customer(customer_invoices)
    customer_ids_and_totals = Hash[customer_ids.zip(customer_totals)]
    ids_for_top_customers = find_ids_for_top_customers(customer_ids_and_totals, top_customers)
    find_customers_from_customer_ids(ids_for_top_customers)
  end

  def top_merchant_for_customer(customer_id)
    invoices_for_customer = @parent.invoices.customer_id[customer_id]
    quantity_for_invoices = calculate_quantity_for_invoices(invoices_for_customer)
    max_items = quantity_for_invoices.compact.max
    index_value_max_items = quantity_for_invoices.index(max_items)
    top_merchant_id = invoices_for_customer[index_value_max_items].merchant_id
    # require "pry"; binding.pry
    @parent.merchants.find_by_id(top_merchant_id)
  end

  def one_time_buyers
    invoices_per_customer = @parent.invoices.customer_id.values
    customers_with_single_purchase(invoices_per_customer)
  end

  def one_time_buyers_top_item
    hash = Hash.new(0)
    j = one_time_buyers.map do |customer|
      customer_id = customer.id
      invoice = @parent.invoices.find_all_by_customer_id(customer_id)
      invoice_id = invoice.first.id
      invoice_items = @parent.invoice_items.find_all_by_invoice_id(invoice_id)
      invoice_items.each do |invoice_item|
        x = invoice_item.item_id
         hash[x] = hash[x] + invoice_item.quantity.to_i
      end
    end
    highest_quantity_index = hash.values.index(hash.values.max)
    item_id_highest_quantity = hash.keys[highest_quantity_index]
    @parent.items.find_by_id(item_id_highest_quantity)
  end

  def items_bought_in_year(customer_id, year)
    customer_invoices = @parent.invoices.find_all_by_customer_id(customer_id)
    customer_invoice_items = find_all_customer_invoice_items(customer_invoices, year)
    customer_invoice_items.map do |invoice_item|
      item = invoice_item.item_id
        @parent.items.find_by_id(item)
    end.flatten
  end

  def highest_volume_items(customer_id)
    invoices_per_customer = @parent.invoices.find_all_by_customer_id(customer_id)
    invoice_items_per_customer = find_invoice_items_per_customer(invoices_per_customer)
    item_id_quantities = find_item_id_quantities(invoice_items_per_customer)
    item_id_quantities.keep_if do |item_id|
      item_id_quantities[item_id] == item_id_quantities.values.max
    end
    item_id_quantities.keys.map do |item_id|
      @parent.items.find_by_id(item_id)
    end
  end

  def customers_with_unpaid_invoices
    unpaid_invoices = @parent.invoices.all.map do |invoice|
      invoice_id = invoice.id
      unless invoice_paid_in_full?(invoice_id)
        invoice
      end
    end.compact
    find_customers_with_unpaid_invoices(unpaid_invoices)
  end

  def best_invoice_by_revenue
    paid_invoices = @parent.invoices.all.map do |invoice|
      invoice_id = invoice.id
      if invoice_paid_in_full?(invoice_id)
        invoice
      end
    end.compact
    invoice_items_by_invoices = paid_invoices.map do |invoice|
      invoice_id = invoice.id
      @parent.invoice_items.find_all_by_invoice_id(invoice_id)
    end
     revenue_by_invoice = invoice_items_by_invoices.map do |invoice_items|
      invoice_items.inject(0) do |sum, invoice_item|
        sum + (invoice_item.quantity.to_i * invoice_item.unit_price_to_dollars)
      end
    end.flatten
    max_revenue = revenue_by_invoice.max
    max_revenue_index = revenue_by_invoice.index(max_revenue)
    paid_invoices[max_revenue_index]
  end

  def best_invoice_by_quantity
    paid_invoices = @parent.invoices.all.map do |invoice|
      invoice_id = invoice.id
      if invoice_paid_in_full?(invoice_id)
        invoice
      end
    end.compact
    invoice_items_by_invoices = paid_invoices.map do |invoice|
      invoice_id = invoice.id
      @parent.invoice_items.find_all_by_invoice_id(invoice_id)
    end
     revenue_by_invoice = invoice_items_by_invoices.map do |invoice_items|
      invoice_items.inject(0) do |sum, invoice_item|
        sum + invoice_item.quantity.to_i
      end
    end.flatten
    max_revenue = revenue_by_invoice.max
    max_revenue_index = revenue_by_invoice.index(max_revenue)
    paid_invoices[max_revenue_index]
  end

end
