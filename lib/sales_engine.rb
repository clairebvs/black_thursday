require_relative 'file_loader'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'sales_analyst'
require_relative 'invoice_item_repository'

class SalesEngine
  include FileLoader

  def initialize(file_paths)
    @file_paths = file_paths
  end

  def self.from_csv(file_paths)
    new(file_paths)
  end

  def items
    @items ||= ItemRepository.new(open_items_csv(@file_paths[:items]), self)
  end

  def merchants
    @merchants ||= MerchantRepository.new(open_items_csv(@file_paths[:merchants]), self)
  end

  def invoices
    @invoices ||= InvoiceRepository.new(open_items_csv(@file_paths[:invoices]), self)
  end

  def invoice_items
    @invoice_items ||= InvoiceItemRepository.new(open_items_csv(@file_paths[:invoice_items]), self)
  end

  def analyst
    SalesAnalyst.new(self)
  end
end
