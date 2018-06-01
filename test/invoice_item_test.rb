require './test/test_helper'
require './lib/sales_engine'

class InvoiceItemTest < Minitest::Test
  def test_it_exists
    file_paths = {invoice_items:  "./data/invoice_items.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @invoice_items = engine.invoice_items
    all_invoice_items = @invoice_items.all
    invoice_item = all_invoice_items[0]

    assert_instance_of InvoiceItem, invoice_item
  end

  def test_it_has_attributes
    file_paths = {invoice_items:  "./data/invoice_items.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @invoice_items = engine.invoice_items
    all_invoice_items = @invoice_items.all
    invoice_item = all_invoice_items[0]

    assert_equal 1, invoice_item.id
    assert_equal 263519844, invoice_item.item_id
    assert_equal 1, invoice_item.invoice_id
    assert_equal "5", invoice_item.quantity
    assert_equal 136.35, invoice_item.unit_price
    assert_equal Time.parse('2012-03-27 14:54:09 UTC'), invoice_item.created_at
    assert_equal Time.parse('2012-03-27 14:54:09 UTC'), invoice_item.updated_at
  end

  def test_invoice_item_can_have_different_attributes
    file_paths = {invoice_items:  "./data/invoice_items.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @invoice_items = engine.invoice_items
    all_invoice_items = @invoice_items.all
    invoice_item = all_invoice_items[1]

    assert_equal 2, invoice_item.id
    assert_equal 263454779, invoice_item.item_id
    assert_equal 1, invoice_item.invoice_id
    assert_equal "9", invoice_item.quantity
    assert_equal 233.24, invoice_item.unit_price
    assert_equal Time.parse('2012-03-27 14:54:09 UTC'), invoice_item.created_at
    assert_equal Time.parse('2012-03-27 14:54:09 UTC'), invoice_item.updated_at
  end

  def test_can_convert_unit_price_to_dollars
    file_paths = {invoice_items:  "./data/invoice_items.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @invoice_items = engine.invoice_items
    all_invoice_items = @invoice_items.all
    invoice_item = all_invoice_items[0]

    assert_equal 136.35, invoice_item.unit_price_to_dollars
  end

  def test_can_update_time_for_invoice_item
    file_paths = {invoice_items:  "./data/invoice_items.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @invoice_items = engine.invoice_items
    all_invoice_items = @invoice_items.all
    invoice_item = all_invoice_items[0]

    assert_equal Time.parse('2012-03-27 14:54:09 UTC'), invoice_item.updated_at
    refute_match Time.parse('2012-03-27 14:54:09 UTC'), invoice_item.update_time
  end
end
