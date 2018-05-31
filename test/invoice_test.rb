require './test/test_helper'
require './lib/sales_engine'

class InvoiceTest < Minitest::Test
  def test_it_exists
    file_paths = {invoices:  "./data/invoices.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @invoices = engine.invoices
    all_invoices = @invoices.all
    invoice = all_invoices[0]

    assert_instance_of Invoice, invoice
  end

  def test_it_has_attributes
    file_paths = {invoices:  "./data/invoices.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @invoices = engine.invoices
    all_invoices = @invoices.all
    invoice = all_invoices[0]

    assert_equal 1, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 12335938, invoice.merchant_id
    assert_equal :pending, invoice.status
    assert_equal Time.parse('2009-02-07'), invoice.created_at
    assert_equal Time.parse('2014-03-15'), invoice.updated_at
  end

  def test_invoice_can_have_different_attributes
    file_paths = {invoices:  "./data/invoices.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @invoices = engine.invoices
    all_invoices = @invoices.all
    invoice = all_invoices[1]

    assert_equal 2, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 12334753, invoice.merchant_id
    assert_equal :shipped, invoice.status
    assert_equal Time.parse('2012-11-23'), invoice.created_at
    assert_equal Time.parse('2013-04-14'), invoice.updated_at
  end

  def test_can_update_time_for_invoice
    file_paths = {invoices:  "./data/invoices.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @invoices = engine.invoices
    all_invoices = @invoices.all
    invoice = all_invoices[0]

    assert_equal Time.parse('2014-03-15'), invoice.updated_at
    refute_match Time.parse('2014-03-15'), invoice.update_time
  end
end
