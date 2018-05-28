require 'time'

class Merchant
  attr_accessor :name
  attr_reader :parent,
              :id,
              :created_at,
              :updated_at

  def initialize(merchant, parent)
    @parent = parent
    @id = merchant[:id].to_i
    @name = merchant[:name]
    @created_at = merchant[:created_at]
    @updated_at = merchant[:updated_at]
  end

  def update_time
    @updated_at = Time.now.strftime('%Y-%m-%d')
  end
end
