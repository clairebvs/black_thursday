require './test/test_helper'
require './lib/sales_engine'

class CustomerTest < Minitest::Test
  def test_it_exists
    file_paths = {customers:  "./data/customers.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @customers = engine.customers
    all_customers = @customers.all
    customer = all_customers[0]

    assert_instance_of Customer, customer
  end

  def test_it_has_attributes
    file_paths = {customers:  "./data/customers.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @customers = engine.customers
    all_customers = @customers.all
    customer = all_customers[0]

    assert_equal 1, customer.id
    assert_equal 'Joey', customer.first_name
    assert_equal 'Ondricka', customer.last_name
    assert_equal Time.parse('2012-03-27 14:54:09 UTC'), customer.created_at
    assert_equal Time.parse('2012-03-27 14:54:09 UTC'), customer.updated_at
  end

  def test_item_can_have_different_attributes
    file_paths = {customers:  "./data/customers.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @customers = engine.customers
    all_customers = @customers.all
    customer = all_customers[1]

    assert_equal 2, customer.id
    assert_equal 'Cecelia', customer.first_name
    assert_equal 'Osinski', customer.last_name
    assert_equal Time.parse('2012-03-27 14:54:10 UTC'), customer.created_at
    assert_equal Time.parse('2012-03-27 14:54:10 UTC'), customer.updated_at
  end

  def test_can_update_time_for_invoice
    file_paths = {customers:  "./data/customers.csv"}
    engine = SalesEngine.from_csv(file_paths)
    @customers = engine.customers
    all_customers = @customers.all
    customer = all_customers[0]

    assert_equal Time.parse('2012-03-27 14:54:09 UTC'), customer.updated_at
    refute_match Time.parse('2012-03-27 14:54:09 UTC'), customer.update_time
  end
end
