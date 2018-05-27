class Merchant
  attr_reader :parent,
              :id,
              :name,
              :created_at,
              :updated_at

  def initialize(merchant, parent)
    @parent = parent
    @id = merchant[:id].to_i
    @name = merchant[:name]
    @created_at = merchant[:created_at]
    @updated_at = merchant[:updated_at]
  end

end
