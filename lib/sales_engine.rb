require './lib/file_loader'
require './lib/item_repository'

class SalesEngine
  include FileLoader

  def initialize
    @file_paths = { items:      './data/items.csv',
                    merchants:  './data/merchants.csv' }
  end

  def items
    access_csv = open_items_csv(@file_paths[:items])
    @items ||= ItemRepository.new(access_csv, self)
  end
end
