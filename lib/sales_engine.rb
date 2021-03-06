require_relative 'file_loader'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'invoice_item_repository'
require_relative 'sales_analyst'

class SalesEngine
  include FileLoader

  def initialize(file_paths)
    @file_paths = file_paths
  end

  def self.from_csv(file_paths)
    new(file_paths)
  end

  def items
    @items ||= ItemRepository.new(open_items_csv(@file_paths[:items]))
  end

  def merchants
    @merchants ||= MerchantRepository.new(open_items_csv(@file_paths[:merchants]))
  end

  def invoices
    @invoices ||= InvoiceRepository.new(open_items_csv(@file_paths[:invoices]))
  end

  def transactions
    @transactions ||= TransactionRepository.new(open_items_csv(@file_paths[:transactions]))
  end

  def customers
    @customers ||= CustomerRepository.new(open_items_csv(@file_paths[:customers]))
  end

  def invoice_items
    @invoice_items ||= InvoiceItemRepository.new(open_items_csv(@file_paths[:invoice_items]))
  end

  def analyst
    SalesAnalyst.new(self)
  end
end
