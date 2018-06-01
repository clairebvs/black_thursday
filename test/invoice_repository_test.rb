require './test/test_helper'
require './lib/sales_engine'
require './lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    file_paths = { invoices:      './data/invoices.csv' }
    engine = SalesEngine.from_csv(file_paths)
    @invoices = engine.invoices
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoices
  end

  def test_hash_tables_are_built
    id = @invoices.id
    assert_instance_of Hash, id
  end

  def test_all_returns_array_of_invoices
    all_invoices = @invoices.all
    actual1 = all_invoices[50].merchant_id
    actual2 = all_invoices[3352].merchant_id
    assert_equal 12_335_314, actual1
    assert_equal 12_334_814, actual2
  end

  def test_can_find_by_id
    actual1 = @invoices.find_by_id(3_350).status
    actual2 = @invoices.find_by_id(5).status
    assert_equal :returned, actual1
    assert_equal :pending, actual2
  end

  def test_can_find_all_by_customer_id
    actual1 = @invoices.find_all_by_customer_id(1)
    actual2 = @invoices.find_all_by_customer_id(79)
    assert_equal 8, actual1.length
    assert_equal 8, actual2.length
  end

  def test_can_find_all_by_merchant_id
    actual1 = @invoices.find_all_by_merchant_id(12_334_839)
    actual2 = @invoices.find_all_by_merchant_id(12_336_163)
    assert_equal 9, actual1.length
    assert_equal 11, actual2.length
  end

  def test_can_find_all_by_status
    actual1 = @invoices.find_all_by_status(:shipped)
    actual2 = @invoices.find_all_by_status(:pending)
    assert_equal 2839, actual1.length
    assert_equal 1473, actual2.length
  end

  def test_can_find_last_element_id_plus_one
    expected = 4986
    actual = @invoices.last_element_id_plus_one
    assert_equal expected, actual
  end

  def test_can_create_an_entry
    attributes =  {
                    :customer_id => 7,
                    :merchant_id => 8,
                    :status      => "pending",
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                  }
    @invoices.create(attributes)
    actual = @invoices.all.last.merchant_id
    assert_equal 8, actual
  end

  def test_can_update_an_entry
    id = 4985
    attributes = {
                   status: :returned
                 }
    actual1 = @invoices.find_by_id(id).status
    assert_equal :shipped, actual1
    @invoices.update(id, attributes)
    actual2 = @invoices.find_by_id(id).status
    assert_equal :returned, actual2
  end

  def test_can_delete_by_id
    last_invoice = @invoices.all.last
    assert_instance_of Invoice, last_invoice
    last_id = last_invoice.id
    @invoices.delete(last_id)
    assert_nil @invoices.find_by_id(last_id)
  end

  def test_inspect_returnd_correct_string
    assert_equal '#<Array 4985 rows>', @invoices.inspect
  end
end
