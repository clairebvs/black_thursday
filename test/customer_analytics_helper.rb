require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer_analytics_helper'
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

  def test_can_calculate_totals_per_customer
    customer_invoices = @engine.invoices.customer_id.values

    assert_equal 901, @sales_analyst.calculate_totals_per_customer(customer_invoices).length
    assert_instance_of BigDecimal, @sales_analyst.calculate_totals_per_customer(customer_invoices)[0]
  end

  def test_can_find_ids_for_top_customers
    customer_ids = @engine.invoices.customer_id.keys
    customer_invoices = @engine.invoices.customer_id.values
    customer_totals = @sales_analyst.calculate_totals_per_customer(customer_invoices)
    customers_ids_and_totals = Hash[customer_ids.zip(customer_totals)]


    assert_equal 7, @sales_analyst.find_ids_for_top_customers(customers_ids_and_totals, top_customers = 7).length
    assert_instance_of Fixnum, @sales_analyst.find_ids_for_top_customers(customers_ids_and_totals, top_customers = 7)[0]
  end

  def test_can_find_customers_by_customer_id
    top_customers = 5
    customer_ids = @engine.invoices.customer_id.keys
    customer_invoices = @engine.invoices.customer_id.values
    customer_totals = @sales_analyst.calculate_totals_per_customer(customer_invoices)
    customer_ids_and_totals = Hash[customer_ids.zip(customer_totals)]
    ids_for_top_customers = @sales_analyst.find_ids_for_top_customers(customer_ids_and_totals, top_customers)

    assert_equal 5, @sales_analyst.find_customers_from_customer_ids(ids_for_top_customers).length
    assert_instance_of Customer, @sales_analyst.find_customers_from_customer_ids(ids_for_top_customers)[0]
  end

  def test_can_calculate_number_of_items_per_invoice
    invoice_id = 1

    assert_equal 47, @sales_analyst.calculate_number_of_items_per_invoice(invoice_id)
  end

  def test_can_calculate_quantity_for_invoices
    skip
    customer_id = 12335955
    invoices_for_customer = @engine.invoices.customer_id[customer_id]

    assert_equal 2, @sales_analyst.calculate_quantity_for_invoices(invoices_for_customer)
  end

  def test_if_customers_made_single_purchase
    
  end

end
