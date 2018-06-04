require './test/test_helper'
require './lib/sales_engine'
require './lib/file_loader'
require './lib/sales_analyst'

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
    engine = SalesEngine.from_csv(file_paths)
    @sales_analyst = engine.analyst
  end

  # def test_attribute_parent
  #   assert_instance_of SalesEngine, @sales_analyst.parent
  # end
  #
  # def test_can_calculate_average_items_per_merchant
  #   actual = @sales_analyst.average_items_per_merchant
  #   assert_equal 2.88, actual
  # end
  #
  # def test_can_calculate_average_items_per_merchant_standard_deviation
  #   actual = @sales_analyst.average_items_per_merchant_standard_deviation
  #   assert_equal 3.26, actual
  # end
  #
  # def test_can_calculate_merchants_with_high_item_count
  #   actual = @sales_analyst.merchants_with_high_item_count
  #   assert_equal 52, actual.length
  #   assert_instance_of Merchant, actual.first
  # end
  #
  # def test_can_calculate_average_item_price_for_merchant
  #   merchant_id = 12334105
  #   actual = @sales_analyst.average_item_price_for_merchant(merchant_id)
  #   assert_equal 16.66, actual.to_f
  # end
  #
  # def test_can_calculate_average_average_price_per_merchant
  #   actual = @sales_analyst.average_average_price_per_merchant
  #   assert_equal 350.29, actual.to_f
  # end
  #
  # def test_can_calculate_golden_items
  #   actual = @sales_analyst.golden_items
  #   assert_equal 5, actual.length
  #   assert_instance_of Item, actual.first
  # end
  #
  # def test_can_calculate_average_invoices_per_merchant
  #   actual = @sales_analyst.average_invoices_per_merchant
  #   assert_equal 10.49, actual
  # end
  #
  # def test_can_calculate_average_invoices_per_merchant_standard_deviation
  #   actual = @sales_analyst.average_invoices_per_merchant_standard_deviation
  #   assert_equal 3.29, actual
  # end

  def test_can_calculate_top_merchants_by_invoice_count
    actual = @sales_analyst.top_merchants_by_invoice_count
    assert_equal 12, actual.length
    assert_instance_of Merchant, actual.first
  end

  # def test_can_calculate_
  #   actual = @sales_analyst.
  #   assert_equal 0, actual
  # end
  #
  # def test_can_calculate_
  #   actual = @sales_analyst.
  #   assert_equal 0, actual
  # end
  #
  # def test_can_calculate_
  #   actual = @sales_analyst.
  #   assert_equal 0, actual
  # end
  #
  # def test_can_calculate_
  #   actual = @sales_analyst.
  #   assert_equal 0, actual
  # end
  #
  # def test_can_calculate_
  #   actual = @sales_analyst.
  #   assert_equal 0, actual
  # end



end
