class MerchantRepository
  attr_reader :parent

  def initialize(merchants, parent)
    @repository = merchants.map { |merchant| Merchant.new(merchant, self) }
    @parent = parent
  end

  def build_hash_table
    @id = @repository.group_by { |merchant| merchant.id }
    @name = @repository.group_by { |merchant| merchant.name }
    @created_at = @repository.group_by { |merchant| merchant.created_at }
    @updated_at = @repository.group_by { |merchant| merchant.updated_at }
  end

  def find_by_id(id)
    @repository.find_all do |merchant|
      merchant.id
    end
  end

end
