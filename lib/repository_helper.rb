module RepositoryHelper
  def all
    @repository
  end

  def last_element_id_plus_one
    last_element = @repository.last
    last_element.id + 1
  end

  def delete(id)
    delete_element = find_by_id(id)
    @repository.delete(delete_element)
  end

  def inspect
    "#<#{self.class} #{self.size} rows>"
  end
end
