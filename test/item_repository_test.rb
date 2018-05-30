require './test/test_helper'
require './lib/sales_engine'
require './lib/file_loader'
require './lib/item_repository'
require './lib/item'

class ItemRepositoryTest < Minitest::Test

  def setup
    file_paths = { items:      './data/items.csv',
                   merchants:  './data/merchants.csv' }
    @engine = SalesEngine.from_csv(file_paths)
  end

  def test_it_exists
    items = @engine.items
    assert_instance_of ItemRepository, items
  end

  def test_parent_points_to_sales_engine
    assert_instance_of SalesEngine, @engine.items.parent
  end

  def test_all_returns_item_array

  end

end
