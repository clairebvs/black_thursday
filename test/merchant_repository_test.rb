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

  def test_find_merchant_by_id
    file_paths = { items:      './data/items.csv',
                   merchants:  './data/merchants.csv' }
    engine = SalesEngine.from_csv(file_paths)
    merchants = engine.merchants

    actual = merchants.find_by_id(12334113)
    expected = 'MiniatureBikez'

    assert_equal expected, actual
  end

  def test_find_merchant_by_name
    file_paths = { items:      './data/items.csv',
                   merchants:  './data/merchants.csv' }
    engine = SalesEngine.from_csv(file_paths)
    merchants = engine.merchants

    actual = merchants.find_by_name("keckenbauer").id
    expected = 12334123

    assert_equal expected, actual
  end

  def test_find_multiple_merchant_by_their_name
    file_paths = { items:      './data/items.csv',
                   merchants:  './data/merchants.csv' }
    engine = SalesEngine.from_csv(file_paths)
    merchants = engine.merchants

    expected = 12334115
    actual = merchants.find_all_by_name("LolaM")

    assert_equal expected, actual
  end

  def test_can_delete_merchant_instance_of_corresponding_id
    file_paths = { items:      './data/items.csv',
                   merchants:  './data/merchants.csv' }
    engine = SalesEngine.from_csv(file_paths)
    merchants = engine.merchants

    merchants.delete(12334132)
    actual = merchants.find_by_id(12334132)

    assert_nil actual
  end

  def test_all_returns_all_the_merchants
   file_paths = { items:      './data/items.csv',
                  merchants:  './data/merchants.csv' }
   engine = SalesEngine.from_csv(file_paths)
   merchants = engine.merchants
   assert_equal 475, merchants.all.count
 end

 def test_can_create_a_merchant_with_last_id_plus_one
   file_paths = { items:      './data/items.csv',
                  merchants:  './data/merchants.csv' }
   engine = SalesEngine.from_csv(file_paths)
   merchants = engine.merchants
   merchants.create({name: "Bobs Best Bowling Balls"})
   actual = engine.merchants.find_by_id(12337412)
   assert_equal  "Bobs Best Bowling Balls", actual.name
 end

 def test_can_update_a_merchant_name
   file_paths = { items:      './data/items.csv',
                  merchants:  './data/merchants.csv' }
   engine = SalesEngine.from_csv(file_paths)
   merchants = engine.merchants
   merchants.create({name: "Bobs Best Bowling Balls"})
   attributes = {name: "Billys Best Bowling Balls"}
   merchants.update(12337412, attributes)
   actual = engine.merchants.find_by_id(12337412)
   assert_equal  "Billys Best Bowling Balls", actual.name
 end
end
