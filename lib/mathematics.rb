module Mathematics

  def calculate_mean(data_set)
    sum_numbers = data_set.inject(0) do |sum, data|
      sum += data
    end
    sum_numbers.to_f / data_set.length
  end

  def sum_square_difference_sum(data_set, mean)
    data_set.inject(0) do |sum, data|
      sum += ((data - mean)**2)
    end
  end

  def divide_by_elements(data_set, square_sum)
    num_of_elements = data_set.length
    square_sum / (num_of_elements - 1)
  end

  def standard_deviation(data_set)
    mean = calculate_mean(data_set)
    square_sum = sum_square_difference_sum(data_set, mean)
    squared_standard_deviation = divide_by_elements(data_set, square_sum)
    Math.sqrt(squared_standard_deviation).round(2)
  end
end
