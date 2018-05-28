require './test/test_helper'
require './lib/sales_engine'
require './lib/file_loader'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    file_paths = { items:      './data/items.csv',
                   merchants:  './data/merchants.csv' }
    engine = SalesEngine.from_csv(file_paths)

    assert_instance_of SalesEngine, engine
  end

  # def test_can_open_items_file
  #   skip
  #   engine = SalesEngine.new
  #   file_path = './data/items.csv'
  #   x = engine.open_items_csv(file_path)
  #   assert x.include?("Pink")
  # end
end
