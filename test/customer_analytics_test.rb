require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'
require 'bigdecimal'

class SalesAnalystTest < Minitest::Test
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
end
