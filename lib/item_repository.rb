class ItemRepository

  def initialize(items, self)
    @repo = items.map {|item| Item.new(item, self)}
  end

  def build_hash_table
    @id = @repo.group_by do |item|
      item.id
    end
    @name = @repo.group_by do |item|
      item.name
    end
    @description = @repo.group_by do |item|
      item.descritpion
    end
    @unit_price = @repo.group_by do |item|
      item.unit_price
    end
    @merchant_id = @repo.group_by do |item|
      item.merchant_id
    end
    @created_at = @repo.group_by do |item|
      item.created_at
    end
    @updated_at = @repo.group_by do |item|
      item.updated_at
    end
  end

end
