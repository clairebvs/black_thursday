require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :id

  def initialize(invoice_items, parent)
    @repository = invoice_items.map { |invoice_item| InvoiceItem.new(invoice_item, self) }
    @parent = parent
    build_hash_table
  end

  def build_hash_table
    @id = @repository.group_by { |invoice_item| invoice_item.id }
    @item_id = @repository.group_by { |invoice_item| invoice_item.item_id }
    @invoice_id = @repository.group_by { |invoice_item| invoice_item.invoice_id }
    @quantity = @repository.group_by { |invoice_item| invoice_item.quantity }
    @unit_price = @repository.group_by { |invoice_item| invoice_item.unit_price }
    @created_at = @repository.group_by { |invoice_item| invoice_item.created_at }
    @updated_at = @repository.group_by { |invoice_item| invoice_item.updated_at }
  end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find do |invoice_item|
      id == invoice_item.id
    end
  end

  def find_all_by_item_id(item_id)
    @repository.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @repository.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def last_invoice_item_id_plus_one
    last_invoice_item = @repository.last
    last_invoice_item.id + 1
  end

  def create(attributes)
    new_last_invoice_item_id = last_invoice_item_id_plus_one
    attributes[:id] = new_last_invoice_item_id
    @repository << InvoiceItem.new(attributes, self)
  end

  def update(id, attribute)
    if !find_by_id(id).nil? && attribute.length.positive?
      invoice_item = find_by_id(id)
      invoice_item.quantity = attribute[:quantity] unless attributes[:quantity].nil?
      invoice_item.unit_price = attribute[:unit_price] unless attribute[:unit_price].nil?
      invoice_item.update_time
    end
  end

  def delete(id)
    delete_invoice_item = find_by_id(id)
    @repository.delete(delete_invoice_item)
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
end
