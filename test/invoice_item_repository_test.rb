require './test/test_helper'
require './lib/sales_engine'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    file_paths = { invoice_items:      './data/invoice_items.csv' }
    engine = SalesEngine.from_csv(file_paths)
    @invoice_items = engine.invoice_items
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @invoice_items
  end

  def test_hash_tables_are_built
    quantity = @invoice_items.quantity
    assert_instance_of Hash, quantity
  end

  def test_all_returns_array_of_invoice_items
    all_invoice_items = @invoice_items.all
    actual1 = all_invoice_items[235].item_id
    actual2 = all_invoice_items[20].quantity
    assert_equal 263_425_975, actual1
    assert_equal '2', actual2
  end

  def test_can_find_by_id
    actual1 = @invoice_items.find_by_id(240).quantity
    actual2 = @invoice_items.find_by_id(5).quantity
    assert_equal '1', actual1
    assert_equal '7', actual2
  end

  def test_can_find_all_by_item_id
    actual1 = @invoice_items.find_all_by_item_id(263_454_435)
    actual2 = @invoice_items.find_all_by_item_id(263_543_430)
    assert_equal 15, actual1.length
    assert_equal '10', actual1.first.quantity
    assert_equal '2', actual2.last.quantity
  end

  def test_can_find_by_invoice_id
    actual1 = @invoice_items.find_all_by_invoice_id(1)
    actual2 = @invoice_items.find_all_by_invoice_id(988)
    assert_equal '5', actual1.first.quantity
    assert_equal '6', actual1.last.quantity
    assert_equal '4', actual2.first.quantity
    assert_equal '3', actual2.last.quantity
  end

  def test_can_find_last_element_id_plus_one
    expected = 21831
    actual = @invoice_items.last_element_id_plus_one
    assert_equal expected, actual
  end

  def test_can_create_an_entry
    attributes =  {
                    :item_id => 7,
                    :invoice_id => 8,
                    :quantity => 1,
                    :unit_price => BigDecimal(10.99, 4),
                    :created_at => Time.now,
                    :updated_at => Time.now
                  }
    @invoice_items.create(attributes)
    actual = @invoice_items.all.last.quantity
    assert_equal 1, actual
  end

  def test_can_update_an_entry
    id = 21830
    attributes = {
                   :quantity => '13'
                 }
    actual1 = @invoice_items.find_by_id(id).quantity
    assert_equal '4', actual1
    @invoice_items.update(id, attributes)
    actual2 = @invoice_items.find_by_id(id).quantity
    assert_equal '13', actual2
  end

  def test_can_delete_by_id
    last_invoice_item = @invoice_items.all.last
    assert_instance_of InvoiceItem, last_invoice_item
    last_id = last_invoice_item.id
    @invoice_items.delete(last_id)
    assert_nil @invoice_items.find_by_id(last_id)
  end

  def test_inspect_returnd_correct_string
    assert_equal '#<Array 21830 rows>', @invoice_items.inspect
  end
end
