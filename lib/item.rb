require 'bigdecimal'
require 'time'

class Item
  attr_accessor :name,
                :description,
                :unit_price,
                :unit_price_to_dollars

  attr_reader :id,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(item)
    @id = item[:id].to_i
    @name = item[:name]
    @description = item[:description]
    @unit_price = BigDecimal(item[:unit_price].to_i) / 100
    @unit_price_to_dollars = item[:unit_price].to_i / 100.00
    @merchant_id = item[:merchant_id]
    @created_at = Time.parse(item[:created_at].to_s)
    @updated_at = Time.parse(item[:updated_at].to_s)
  end

  def update_time
    @updated_at = Time.now.utc
  end
end
