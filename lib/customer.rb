require 'time'

class Customer
  attr_accessor :first_name,
                :last_name
  attr_reader :id,
              :created_at,
              :updated_at

  def initialize(customer)
    @id = customer[:id].to_i
    @first_name = customer[:first_name]
    @last_name = customer[:last_name]
    @created_at = Time.parse(customer[:created_at].to_s)
    @updated_at = Time.parse(customer[:updated_at].to_s)
  end

  def update_time
    @updated_at = Time.now.utc
  end
end
