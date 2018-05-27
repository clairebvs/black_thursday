require_relative 'item.rb'

class ItemRepository
  attr_reader :parent

  def initialize(items, parent)
    @repository = items.map { |item| Item.new(item, self) }
    @parent = parent
  end

  def build_hash_table
    @id = @repository.group_by { |item| item.id }
    @name = @repository.group_by { |item| item.name }
    @description = @repository.group_by { |item| item.description }
    @unit_price = @repository.group_by { |item| item.unit_price }
    @merchant_id = @repository.group_by { |item| item.merchant_id }
    @created_at = @repository.group_by { |item| item.created_at }
    @updated_at = @repository.group_by { |item| item.updated_at }
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

end
