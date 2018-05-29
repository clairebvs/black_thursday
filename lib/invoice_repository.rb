require_relative 'invoice'

class InvoiceRepository
  attr_reader :parent,
              :merchant_id,
              :status

  def initialize(invoices, parent)
    @repository = invoices.map { |invoice| Invoice.new(invoice, self) }
    @parent = parent
    build_hash_table
  end

  def build_hash_table
    @id = @repository.group_by { |invoice| invoice.id }
    @customer_id = @repository.group_by { |invoice| invoice.customer_id }
    @merchant_id = @repository.group_by { |invoice| invoice.merchant_id }
    @status = @repository.group_by { |invoice| invoice.status }
    @created_at = @repository.group_by { |invoice| invoice.created_at }
    @updated_at = @repository.group_by { |invoice| invoice.updated_at }
  end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find do |invoice|
      id == invoice.id
    end
  end

  def find_all_by_customer_id(customer_id)
    @repository.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @repository.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @repository.find_all do |invoice|
      invoice.status == status
    end
  end

  def last_invoice_id_plus_one
    last_invoice = @repository.last
    last_invoice.id + 1
  end

  def create(attributes)
    new_last_invoice_id = last_invoice_id_plus_one
    attributes[:id] = new_last_invoice_id
    @repository << Invoice.new(attributes, self)
  end

  def update(id, attributes)
    if !find_by_id(id).nil? && attributes.length.positive?
      invoice = find_by_id(id)
      invoice.status = attributes[:status] unless attributes[:status].nil?
      invoice.update_time
    end
  end

  def delete(id)
    delete_invoice = find_by_id(id)
    @repository.delete(delete_invoice)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end
