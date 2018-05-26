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

  def build_hash_table
    @id = @repository.group_by { |item| item.id }
    @name = @repository.group_by { |item| item.name }
    @created_at = @repository.group_by { |item| item.created_at }
    @updated_at = @repository.group_by { |item| item.updated_at }
  end
end
