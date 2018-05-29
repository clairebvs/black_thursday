require_relative 'transaction'

class TransactionRepository
  attr_reader :result

  def initialize(transactions, parent)
    @repository = transactions.map { |transaction| Transaction.new(transaction, self) }
    @parent = parent
    build_hash_table
  end

  def build_hash_table
    @id = @repository.group_by { |transaction| transaction.id }
    @invoice_id = @repository.group_by { |transaction| transaction.invoice_id }
    @credit_card_number = @repository.group_by { |transaction| transaction.credit_card_number }
    @credit_card_expiration_date = @repository.group_by { |transaction| transaction.credit_card_expiration_date }
    @result = @repository.group_by { |transaction| transaction.result }
    @created_at = @repository.group_by { |transaction| transaction.created_at }
    @updated_at = @repository.group_by { |transaction| transaction.updated_at }
  end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find do |transaction|
      id == transaction.id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @repository.find_all do |transaction|
      invoice_id == transaction.invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    @repository.find_all do |transaction|
      credit_card_number == transaction.credit_card_number
    end
  end

  def find_all_by_result(result)
    @repository.find_all do |transaction|
      result == transaction.result
    end
  end

  def last_transaction_id_plus_one
    last_transaction = @repository.last
    last_transaction.id + 1
  end

  def create(attributes)
    new_last_transaction_id = last_transaction_id_plus_one
    attributes[:id] = new_last_transaction_id
    @repository << Transaction.new(attributes, self)
  end

  def update(id, attributes)
    if !find_by_id(id).nil? && attributes.length.positive?
      transaction = find_by_id(id)
      transaction.credit_card_number = attributes[:credit_card_number] unless attributes[:credit_card_number].nil?
      transaction.credit_card_expiration_date = attributes[:credit_card_expiration_date] unless attributes[:credit_card_expiration_date].nil?
      transaction.result = attributes[:result] unless attributes[:result].nil?
      transaction.update_time
    end
  end

  def delete(id)
    delete_transaction = find_by_id(id)
    @repository.delete(delete_transaction)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
