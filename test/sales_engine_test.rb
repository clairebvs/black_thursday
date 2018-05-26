require './test/test_helper'
require './lib/sales_engine'
require './lib/file_loader'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    engine = SalesEngine.new

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
