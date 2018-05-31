require 'time'
require 'bigdecimal'

class InvoiceItem
  attr_accessor :quantity,
                :unit_price
  attr_reader :id,
              :item_id,
              :invoice_id,
              :unit_price_to_dollars,
              :created_at,
              :updated_at

  def initialize(invoice_item)
    @id = invoice_item[:id].to_i
    @item_id = invoice_item[:item_id].to_i
    @invoice_id = invoice_item[:invoice_id].to_i
    @quantity = invoice_item[:quantity]
    @unit_price = BigDecimal(invoice_item[:unit_price].to_i) / 100.00
    @unit_price_to_dollars = invoice_item[:unit_price].to_i / 100.00
    @created_at = Time.parse(invoice_item[:created_at].to_s)
    @updated_at = Time.parse(invoice_item[:updated_at].to_s)
  end

  def update_time
    @updated_at = Time.now
  end
end
