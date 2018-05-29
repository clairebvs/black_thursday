require 'time'

class Invoice
  attr_accessor :status
  attr_reader :parent,
              :id,
              :customer_id,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(invoice, parent)
    @parent = parent
    @id = invoice[:id].to_i
    @customer_id = invoice[:customer_id].to_i
    @merchant_id = invoice[:merchant_id].to_i
    @status = invoice[:status].to_sym
    @created_at = Time.parse(invoice[:created_at].to_s)
    @updated_at = Time.parse(invoice[:updated_at].to_s)
  end

  def update_time
    @updated_at = Time.now
  end
end
