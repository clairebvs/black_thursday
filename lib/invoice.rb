require 'time'

class Invoice
  def initialize(invoice, parent)
    @parent = parent
    @id = invoice[:id].to_i
    @customer_id = invoice[:customer_id]
    @merchant_id = invoice[:merchant_id]
    @status = invoice[:status]
    @created_at = invoice[:created_at]
    @updated_at = invoice[:updated_at]
  end

  def update_time
    @updated_at = Time.now.strftime('%Y-%m-%d')
  end
end
