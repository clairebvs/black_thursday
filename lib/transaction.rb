require 'time'

class Transaction
  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result
  attr_reader :id,
              :invoice_id,
              :created_at,
              :updated_at

  def initialize(transaction, parent)
    @parent = parent
    @id = transaction[:id].to_i
    @invoice_id = transaction[:invoice_id].to_i
    @credit_card_number = transaction[:credit_card_number]
    @credit_card_expiration_date = transaction[:credit_card_expiration_date]
    @result = transaction[:result].to_sym
    @created_at = Time.parse(transaction[:created_at].to_s)
    @updated_at = Time.parse(transaction[:updated_at].to_s)
  end

  def update_time
    @updated_at = Time.now.utc
  end
end
