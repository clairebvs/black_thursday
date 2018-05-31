require './test/test_helper'
require './lib/sales_engine'

class ItemTest < Minitest::Test
  def test_it_exists
    file_paths = {items:  "./data/items.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @items = engine.items
    all_items = @items.all
    item = all_items[0]

    assert_instance_of Item, item
  end

  def test_it_has_attributes
    file_paths = {items:  "./data/items.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @items = engine.items
    all_items = @items.all
    item = all_items[0]

    assert_equal 263395237, item.id
    assert_equal '510+ RealPush Icon Set', item.name
    assert item.description.include?('total socialmedia')
    assert_equal BigDecimal(12.00, 4), item.unit_price
    assert_equal '12334141', item.merchant_id
    assert_equal Time.parse('2016-01-11 09:34:06 UTC'), item.created_at
    assert_equal Time.parse('2007-06-04 21:35:10 UTC'), item.updated_at
  end

  def test_item_can_have_different_attributes
    file_paths = {items:  "./data/items.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @items = engine.items
    all_items = @items.all
    item = all_items[1]

    assert_equal 263395617, item.id
    assert_equal 'Glitter scrabble frames', item.name
    assert item.description.include?('Available colour scrabble tiles')
    assert_equal BigDecimal(13.00, 4), item.unit_price
    assert_equal '12334185', item.merchant_id
    assert_equal Time.parse('2016-01-11 11:51:37 UTC'), item.created_at
    assert_equal Time.parse('1993-09-29 11:56:40 UTC'), item.updated_at
  end

  def test_can_convert_unit_price_to_dollars
    file_paths = {items:  "./data/items.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @items = engine.items
    all_items = @items.all
    item = all_items[0]

    assert_equal 12.00, item.unit_price_to_dollars
  end

  def test_can_update_time_for_item
    file_paths = {items:  "./data/items.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @items = engine.items
    all_items = @items.all
    item = all_items[0]

    assert_equal Time.parse('2007-06-04 21:35:10 UTC'), item.updated_at
    refute_match Time.parse('2007-06-04 21:35:10 UTC'), item.update_time
  end
end
