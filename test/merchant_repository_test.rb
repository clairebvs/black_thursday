require './test/test_helper'
require './lib/sales_engine'
require './lib/file_loader'
require './lib/merchant_repository'
require './lib/merchant'

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    file_paths = { items:      './data/items.csv',
                   merchants:  './data/merchants.csv' }
    engine = SalesEngine.from_csv(file_paths)
    merchants = engine.merchants
    assert_instance_of MerchantRepository, merchants
  end


end
