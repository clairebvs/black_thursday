require_relative 'merchant'

class MerchantRepository
  attr_reader :parent

  def initialize(merchants, parent)
    @repository = merchants.map { |merchant| Merchant.new(merchant, self) }
    @parent = parent
    build_hash_table
  end

  def build_hash_table
    @id = @repository.group_by { |merchant| merchant.id }
    @name = @repository.group_by { |merchant| merchant.name }
    @created_at = @repository.group_by { |merchant| merchant.created_at }
    @updated_at = @repository.group_by { |merchant| merchant.updated_at }
  end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find do |merchant|
      id == merchant.id
    end
  end

  def find_by_name(name)
    @repository.find do |merchant|
      name.downcase == merchant.name.downcase
    end
  end

  def find_all_by_name(name)
    @repository.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    last_merchant_id = find_last_merchant_id
    new_last_merchant_id = last_merchant_id + 1
    attributes[:id] = new_last_merchant_id
    @repository << Merchant.new(attributes, self)
 end

  def find_last_merchant_id
    last_merchant = @repository.last
    last_merchant.id
  end

  def update(id, attributes)
    if attributes.length > 0 && find_by_id(id) != nil
      merchant = find_by_id(id)
      new_name = attributes[:name]
      merchant.name_change(new_name)
    end
  end

  def delete(id)
    delete_merchant = find_by_id(id)
    @repository.delete(delete_merchant)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
