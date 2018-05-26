require './test/test_helper'
require './lib/sales_engine'
require './lib/file_loader'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    items = ItemRepository.new
    assert_instance_of ItemRepository, items
  end
end
