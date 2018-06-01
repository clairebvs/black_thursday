require './test/test_helper'
require './lib/sales_engine'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  def setup
    file_paths = { customers:      './data/customers.csv' }
    engine = SalesEngine.from_csv(file_paths)
    @customers = engine.customers
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @customers
  end

  def test_hash_tables_are_built
    id = @customers.id
    assert_instance_of Hash, id
  end

  def test_all_returns_array_of_customers
    all_customers = @customers.all
    actual1 = all_customers[100].first_name
    actual2 = all_customers[500].last_name
    assert_equal 'Damian', actual1
    assert_equal 'Feil', actual2
  end

  def test_can_find_by_id
    actual1 = @customers.find_by_id(674).first_name
    actual2 = @customers.find_by_id(243).created_at
    expected2 = Time.parse('2012-03-27 14:55:08 UTC')
    assert_equal 'Terrance', actual1
    assert_equal expected2, actual2
  end

  def test_can_find_by_first_name
    actual1 = @customers.find_all_by_first_name('MaCie')
    actual2 = @customers.find_all_by_first_name('michelle')
    assert_equal 'Macie', actual1.first.first_name
    assert_equal 'Macie', actual1.last.first_name
    assert_equal 'Michelle', actual2.first.first_name
    assert_equal 'Michelle', actual2.last.first_name
  end

  def test_can_find_by_last_name
    actual1 = @customers.find_all_by_last_name('nolan')
    actual2 = @customers.find_all_by_last_name('LyncH')
    assert_equal 'Nolan', actual1.first.last_name
    assert_equal 'Nolan', actual1.last.last_name
    assert_equal 'Lynch', actual2.first.last_name
    assert_equal 'Lynch', actual2.last.last_name
  end

  def test_can_find_last_element_id_plus_one
    expected = 1001
    actual = @customers.last_element_id_plus_one
    assert_equal expected, actual
  end

  def test_can_create_an_entry
    attributes = {
                    :first_name => 'Sammy',
                    :last_name => 'Sodapop',
                    :created_at => Time.now,
                    :updated_at => Time.now
                  }
    @customers.create(attributes)
    actual = @customers.all.last.last_name
    assert_equal 'Sodapop', actual
  end

  def test_can_update_an_entry
    id = 99
    attributes = {
                   :first_name => 'John'
                 }
    actual1 = @customers.find_by_id(id).first_name
    assert_equal 'Lonie', actual1
    @customers.update(id, attributes)
    actual2 = @customers.find_by_id(id).first_name
    assert_equal 'John', actual2
  end

  def test_can_delete_by_id
    last_customer = @customers.all.last
    assert_instance_of Customer, last_customer
    last_id = last_customer.id
    @customers.delete(last_id)
    assert_nil @customers.find_by_id(last_id)
  end

  def test_inspect_returnd_correct_string
    assert_equal '#<Array 1000 rows>', @customers.inspect
  end
end
