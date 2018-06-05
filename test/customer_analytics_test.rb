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

    # def test_can_calculate_totals_per_customer
    #   customer_invoices = @engine.invoices.customer_id.values
    #
    #   assert_equal 901, @sales_analyst.calculate_totals_per_customer(customer_invoices).length
    #   assert_instance_of BigDecimal, @sales_analyst.calculate_totals_per_customer(customer_invoices)[0]
    # end
end
