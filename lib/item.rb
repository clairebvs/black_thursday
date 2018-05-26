class Item
  attr_reader :parent,
              :id,
              :name,
              :description,
              :unit_price,
              :merchant,
              :created_at,
              :updated_at

  def initialize(item, parent)
    @parent = parent
    @id = item[:id].to_i
    @name = item[:name]
    @description = item[:description]
    @unit_price = item[:unit_price]
    @merchant = item[:merchant]
    @created_at = item[:created_at]
    @updated_at = item[:updated_at]
  end
end
