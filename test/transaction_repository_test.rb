require './test/test_helper'
require './lib/sales_engine'
require './lib/file_loader'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def setup
    file_paths = { transactions:  './data/transactions.csv' }
    engine = SalesEngine.from_csv(file_paths)
    @transactions = engine.transactions
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @transactions
  end

  def test_hash_tables_are_built
    result = @transactions.result
    assert_instance_of Hash, result
  end

  def test_all_returns_array_of_transactions
    all_transactions = @transactions.all
    actual1 = all_transactions[17].credit_card_number
    actual2 = all_transactions[445].credit_card_number
    assert_equal '4055813232766404', actual1
    assert_equal '4195437675315881', actual2
  end

  def test_find_transaction_by_id
    actual1 = @transactions.find_by_id(115).result
    actual2 = @transactions.find_by_id(320).result
    assert_equal :success, actual1
    assert_equal :success, actual2
  end

  def test_can_find_by_invoice_id
    actual1 = @transactions.find_all_by_invoice_id(2850)
    actual2 = @transactions.find_all_by_invoice_id(3984)
    assert_equal 3, actual1.length
    assert_equal '4656101981467253', actual2.first.credit_card_number
  end

  def test_can_find_all_by_credit_card_number
    ccnum1 = '4725795871599234'
    ccnum2 = '4767767387034388'
    actual1 = @transactions.find_all_by_credit_card_number(ccnum1)
    actual2 = @transactions.find_all_by_credit_card_number(ccnum2)
    assert_equal 2016, actual1.first.id
    assert_equal 2919, actual2.first.id
  end

  def test_can_find_all_by_result
    actual1 = @transactions.find_all_by_result(:success)
    actual2 = @transactions.find_all_by_result(:failed)
    assert_equal 4158, actual1.length
    assert_equal 827, actual2.length
  end

  def test_can_find_last_element_id_plus_one
    expected = 4_986
    actual = @transactions.last_element_id_plus_one
    assert_equal expected, actual
  end

  def test_can_create_an_entry
    attributes =  {
                    :invoice_id => 8,
                    :credit_card_number => "4242424242424242",
                    :credit_card_expiration_date => "0220",
                    :result => "success",
                    :created_at => Time.now,
                    :updated_at => Time.now
                  }
    @transactions.create(attributes)
    actual = @transactions.all.last.credit_card_number
    assert_equal '4242424242424242', actual
  end

  def test_can_update_an_entry
    id = 4_110
    attributes = {
                   result: :failed
                 }
    actual1 = @transactions.find_by_id(id).result
    assert_equal :success, actual1
    @transactions.update(id, attributes)
    actual2 = @transactions.find_by_id(id).result
    assert_equal :failed, actual2
  end

  def test_can_delete_by_id
    last_item = @transactions.all.last
    assert_instance_of Transaction, last_item
    last_id = last_item.id
    @transactions.delete(last_id)
    assert_nil @transactions.find_by_id(last_id)
  end

  def test_inspect_returnd_correct_string
    assert_equal '#<Array 4985 rows>', @transactions.inspect
  end
end
