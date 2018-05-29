require 'time'

class Transaction
  attr_reader :parent,
              :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(transaction, parent)
    @parent = parent
    @id = transaction[:id].to_i
    @invoice_id = transaction[:invoice_id].to_i
    @credit_card_number = transaction[:credit_card_number].to_i
    @credit_card_expiration_date = transaction[:credit_card_expiration_date].to_i
    @result = transaction[:result]
    @created_at = transaction[:created_at]
    @updated_at = transaction[:updated_at]
  end

  def update_time
    @updated_at = Time.now.utc
  end
end
