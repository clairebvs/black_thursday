require './test/test_helper'
require './lib/sales_engine'

class TransactionTest < Minitest::Test
  def test_it_exists
    file_paths = {transactions:  "./data/transactions.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @transactions = engine.transactions
    all_transactions = @transactions.all
    transaction = all_transactions[0]

    assert_instance_of Transaction, transaction
  end

  def test_it_has_attributes
    file_paths = {transactions:  "./data/transactions.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @transactions = engine.transactions
    all_transactions = @transactions.all
    transaction = all_transactions[0]

    assert_equal 1, transaction.id
    assert_equal 2179, transaction.invoice_id
    assert_equal '4068631943231473', transaction.credit_card_number
    assert_equal '0217', transaction.credit_card_expiration_date
    assert_equal :success, transaction.result
    assert_equal Time.parse('2012-02-26 20:56:56 UTC'), transaction.created_at
    assert_equal Time.parse('2012-02-26 20:56:56 UTC'), transaction.updated_at
  end

  def test_transaction_can_have_different_attributes
    file_paths = {transactions:  "./data/transactions.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @transactions = engine.transactions
    all_transactions = @transactions.all
    transaction = all_transactions[1]

    assert_equal 2, transaction.id
    assert_equal 46, transaction.invoice_id
    assert_equal '4177816490204479', transaction.credit_card_number
    assert_equal '0813', transaction.credit_card_expiration_date
    assert_equal :success, transaction.result
    assert_equal Time.parse('2012-02-26 20:56:56 UTC'), transaction.created_at
    assert_equal Time.parse('2012-02-26 20:56:56 UTC'), transaction.updated_at
  end

  def test_can_update_time_for_transaction
    file_paths = {transactions:  "./data/transactions.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @transactions = engine.transactions
    all_transactions = @transactions.all
    transaction = all_transactions[0]

    assert_equal Time.parse('2012-02-26 20:56:56 UTC'), transaction.updated_at
    refute_match Time.parse('2012-02-26 20:56:56 UTC'), transaction.update_time
  end
end
