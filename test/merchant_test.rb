require './test/test_helper'
require './lib/sales_engine'

class MerchantTest < Minitest::Test
  def test_it_exists
    file_paths = {merchants:  "./data/merchants.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @merchants = engine.merchants
    all_merchants = @merchants.all
    merchant = all_merchants[0]

    assert_instance_of Merchant, merchant
  end

  def test_it_has_attributes
    file_paths = {merchants:  "./data/merchants.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @merchants = engine.merchants
    all_merchants = @merchants.all
    merchant = all_merchants[0]

    assert_equal 12334105, merchant.id
    assert_equal 'Shopin1901', merchant.name
    assert_equal '2010-12-10', merchant.created_at
    assert_equal '2011-12-04', merchant.updated_at
  end

  def test_merchant_can_have_different_attributes
    file_paths = {merchants:  "./data/merchants.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @merchants = engine.merchants
    all_merchants = @merchants.all
    merchant = all_merchants[1]

    assert_equal 12334112, merchant.id
    assert_equal 'Candisart', merchant.name
    assert_equal '2009-05-30', merchant.created_at
    assert_equal '2010-08-29', merchant.updated_at
  end

  def test_can_update_time_for_merchant
    file_paths = {merchants:  "./data/merchants.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @merchants = engine.merchants
    all_merchants = @merchants.all
    merchant = all_merchants[0]

    assert_equal '2011-12-04', merchant.updated_at
    refute_match '2011-12-04', merchant.update_time
  end
end
