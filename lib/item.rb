require 'bigdecimal'

class Item
  attr_accessor :name,
                :description,
                :unit_price,
                :unit_price_to_dollars

  attr_reader :parent,
              :id,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(item, parent)
    @parent = parent
    @id = item[:id].to_i
    @name = item[:name]
    @description = item[:description]
    @unit_price = BigDecimal.new(item[:unit_price])
    @unit_price_to_dollars = (item[:unit_price]).to_f
    @merchant_id = item[:merchant_id]
    @created_at = item[:created_at]
    @updated_at = item[:updated_at]
  end

  def update_time
    @updated_at = Time.now.utc
  end
end
