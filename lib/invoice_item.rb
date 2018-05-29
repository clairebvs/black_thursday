require 'time'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(invoice_item, parent)
    @parent = parent
    @id = invoice_item[:id].to_i
    @item_id = invoice_item[:item_id].to_i
    @invoice_id = invoice_item[:invoice_id].to_i
    @quantity = invoice_item[:quantity]
    @unit_price = invoice_item[:unit_price]
    @created_at = Time.parse(invoice_item[:created_at].to_s)
    @updated_at = Time.parse(invoice_item[:updated_at].to_s)
  end

  def update_time
    @updated_at = Time.now
  end

  def unit_price_to_dollars
    @unit_price
  end
end
