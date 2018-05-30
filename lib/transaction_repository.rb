require_relative 'transaction'
require_relative 'repository_helper'

class TransactionRepository
  include RepositoryHelper

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

  def create(attributes)
    attributes[:id] = last_element_id_plus_one
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
end
