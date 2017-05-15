class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end

  private
  def is_valid?(num)
    raise "Out of bounds" if validate!(num)
  end

  def validate!(num)
    num > @max || num < 0
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    idx = num % num_buckets
    @store[idx].include?(num)
  end

  private

  def [](num)
    idx = num % num_buckets
    @store[idx]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if @count == num_buckets
      resize!
    end

    self[num] << num
    @count += 1
  end

  def remove(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private
  def [](num)
    idx = num % num_buckets
    @store[idx]
  end

  def num_buckets
    @store.length
  end

  def resize!
    store_dup = @store.dup
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    store_dup.flatten.each do |num|
      insert(num)
    end
  end
end
