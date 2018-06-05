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
    

  end
    def test_can_calculate_totals_per_customer
      customer_invoices = @engine.invoices.customer_id.values

      assert_equal 901, @sales_analyst.calculate_totals_per_customer(customer_invoices).length
      assert_instance_of BigDecimal, @sales_analyst.calculate_totals_per_customer(customer_invoices)[0]
    end
end
