require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'
require 'bigdecimal'

class CustomerAnalyticsTest < Minitest::Test
  def setup
    file_paths = {
                 customers:      './data/customers.csv',
                 invoice_items:  './data/invoice_items.csv',
                 invoices:       './data/invoices.csv',
                 items:          './data/items.csv',
                 merchants:      './data/merchants.csv',
                 transactions:   './data/transactions.csv'
                }
    @engine = SalesEngine.from_csv(file_paths)
    @sales_analyst = @engine.analyst
  end

  def test_knows_about_top_buyers
    assert_equal 20, @sales_analyst.top_buyers(top_customers = 20).length
    assert_instance_of Customer, @sales_analyst.top_buyers(top_customers = 20)[0]
  end

  def test_can_find_top_merchant_for_customer
    customer_id = 5

    assert_instance_of Merchant, @sales_analyst.top_merchant_for_customer(customer_id)
    assert_equal 12335902, @sales_analyst.top_merchant_for_customer(customer_id).id
  end

  def test_can_find_one_time_buyers
    assert_equal 76, @sales_analyst.one_time_buyers.length
    assert_instance_of Customer, @sales_analyst.one_time_buyers[0]
  end

  def test_can_find_top_item_from_one_time_buyers
    assert_equal 263396463, @sales_analyst.one_time_buyers_top_item.id
    assert_instance_of Item, @sales_analyst.one_time_buyers_top_item
  end

  def test_can_find_items_bought_by_year_and_customer
    year = 2012
    customer_id = 5

    assert_equal 7, @sales_analyst.items_bought_in_year(customer_id, year).length
    assert_instance_of Item, @sales_analyst.items_bought_in_year(customer_id, year)[0]
  end

  def test_can_calculate_highest_volume_items_for_customers
    customer_id1 = 200
    customer_id2 = 30
    actual1 = @sales_analyst.highest_volume_items(customer_id1)
    actual2 = @sales_analyst.highest_volume_items(customer_id2)
    assert_equal 6, actual1.length
    assert_equal 263_420_195, actual1.first.id
    assert_equal 2, actual2.length
    assert_equal 263_538_820, actual2.first.id
  end

  def test_can_find_all_customers_with_unpaid_invoices
    actual = @sales_analyst.customers_with_unpaid_invoices
    assert_equal 786, actual.length
    assert_equal 1, actual.first.id
  end

  def test_can_find_all_paid_in_full_invoices
    actual = @sales_analyst.find_paid_invoices
    assert_equal 2810, actual.length
    assert_equal 1, actual.first.id
  end

  def test_can_calculate_best_invoice_by_revenue
    actual = @sales_analyst.best_invoice_by_revenue
    assert_equal 3394, actual.id
  end

  def test_can_calculate_best_invoice_by_quantity
    actual = @sales_analyst.best_invoice_by_quantity
    assert_equal 1281, actual.id
  end
end
