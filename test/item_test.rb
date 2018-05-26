require 'bigdecimal'
require './test/test_helper'
require './lib/sales_engine'
require './lib/file_loader'
require './lib/item_repository'
require './lib/item'

class ItemTest < Minitest::Test

  def setup
    @item = {
      id:          263395237,
      name:        "Pencil",
      description: "You can use it to write things",
      unit_price:  BigDecimal.new(10.99, 4),
      merchant:    "Helloworld",
      created_at:  "2018-05-26 14:32:37 -0600",
      updated_at:  "2018-05-26 14:32:37 -0600"
      }
  end

  def test_it_exists
    i = Item.new(@item)

    assert_instance_of Item, i
  end


  def test_it_has_attributes
    i = Item.new(@item)

    assert_equal 263395237, i.id
    assert_equal "Pencil", i.name
    assert_equal "You can use it to write things", i.description
    assert_equal BigDecimal.new(10.99, 4), i.unit_price
    assert_equal "Helloworld", i.merchant
    assert_equal "2018-05-26 14:32:37 -0600", i.created_at
    assert_equal "2018-05-26 14:32:37 -0600", i.updated_at


  end
end
