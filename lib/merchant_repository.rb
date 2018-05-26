class MerchantRepository
  attr_reader :parent

  def initialize(merchants, parent)
    @repository = merchants.map { |merchant| Merchant.new(merchant, self) }
    @parent = parent
  end

  def build_hash_table
    @id = @repository.group_by { |item| item.id }
    @name = @repository.group_by { |item| item.name }
    @created_at = @repository.group_by { |item| item.created_at }
    @updated_at = @repository.group_by { |item| item.updated_at }
  end
end
