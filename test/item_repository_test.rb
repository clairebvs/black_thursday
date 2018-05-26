require './test/test_helper'
require './lib/sales_engine'
require './lib/file_loader'
require './lib/item_repository'
require './lib/item'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    file_paths = { items:      './data/items.csv',
                   merchants:  './data/merchants.csv' }
    engine = SalesEngine.from_csv(file_paths)
    items = engine.items
    assert_instance_of ItemRepository, items
  end

end
