require_relative 'customer'
require_relative 'repository_helper'

class CustomerRepository
  include RepositoryHelper

  def initialize(customers, parent)
    @repository = customers.map { |customer| Customer.new(customer, self) }
    @parent = parent
    build_hash_table
  end

  def build_hash_table
    @id = @repository.group_by { |customer| customer.id }
    @first_name = @repository.group_by { |customer| customer.first_name }
    @last_name = @repository.group_by { |customer| customer.last_name }
    @created_at = @repository.group_by { |customer| customer.created_at }
    @updated_at = @repository.group_by { |customer| customer.updated_at }
  end

  def find_by_id(id)
    @repository.find do |customer|
      id == customer.id
    end
  end

  def find_all_by_first_name(first_name)
    @repository.find_all do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    @repository.find_all do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
  end

  def create(attributes)
    new_last_customer_id = last_element_id_plus_one
    attributes[:id] = new_last_customer_id
    @repository << Customer.new(attributes, self)
  end

  def update(id, attributes)
    if !find_by_id(id).nil? && attributes.length.positive?
      customer = find_by_id(id)
      customer.first_name = attributes[:first_name] unless attributes[:first_name].nil?
      customer.last_name = attributes[:last_name] unless attributes[:last_name].nil?
      customer.update_time
    end
  end
end
