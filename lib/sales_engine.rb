require './lib/file_loader'
require './lib/item_repository'

class SalesEngine
  include FileLoader

  def initialize(file_paths)
    @file_paths = file_paths
  end

  def self.from_csv(file_paths)
    new(file_paths)
  end

  def items
    access_csv = open_items_csv(@file_paths[:items])
    @items ||= ItemRepository.new(access_csv, self)
  end

  def merchants
    access_csv = open_items_csv(@file_paths[:merchants])
    @merchants ||= MerchantRepository.new(access_csv, self)
  end
end
