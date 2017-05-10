require 'byebug'

class Array
  def my_uniq
    uniqs = []

    self.each do |el|
      uniqs << el unless uniqs.include?(el)
    end

    uniqs
  end

  def two_sum
    pairs = []

    each_index do |start|
      each_index do |finish|
        next if start >= finish
        result = self[start] + self[finish]
        pairs << [start,finish] if result.zero?
      end
    end
    pairs
  end

  def my_transpose
    each_index do |row|
      each_index do |col|
        break if row == col
        self[row][col], self[col][row] = self[col][row], self[row][col]
      end
    end
  end
end

def stock_picker(arr)
  return nil unless arr.is_a?(Array) && arr.size > 1
  profit_index = []
  profit = 0

  arr.each_with_index do |start_price, start|
    arr.each_with_index do |end_price, finish|
      next if start >= finish
      result = end_price - start_price
      if result > profit
        profit = result
        profit_index = [start, finish]
      end
    end
  end

  profit_index
end
