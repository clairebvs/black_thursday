require './test/test_helper'
require './lib/mathematics'

class MathematicsTest < Minitest::Test
  include Mathematics

  def test_can_sum_all_numbers
    data_set = [1, 2, 3, 4, 5]
    actual = sum_all(data_set)
    assert_equal 15, actual
  end

  def test_can_calculate_mean
    data_set = [5, 10, 15, 20, 25]
    actual = calculate_mean(data_set)
    assert_equal 15, actual
  end

  def test_can_sum_square_difference_sum
    data_set = [5, 10, 15, 20, 25]
    mean = 15
    actual = sum_square_difference_sum(data_set, mean)
    assert_equal 250, actual
  end

  def test_can_divide_by_elements
    data_set = [5, 10, 15, 20, 25]
    mean = 15
    square_sum = sum_square_difference_sum(data_set, mean)
    actual = divide_by_elements(data_set, square_sum)
    assert_equal 62, actual
  end

  def test_can_calculate_standard_deviation
    data_set = [5, 10, 15, 20, 25]
    actual = standard_deviation(data_set)
    assert_equal 7.91, actual
  end

  def test_can_find_percentage
    portion = 50
    total = 100
    actual = find_percentage(portion, total)
    assert_equal 50, actual
  end
end
