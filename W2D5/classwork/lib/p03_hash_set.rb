require_relative 'p02_hashing'
require_relative 'p01_int_set'

class HashSet < ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 8)
    super
  end

  def insert(key)
    return nil if key == nil
    super(key.hash)
  end

  def include?(key)
    super(key.hash)
  end

  def remove(key)
    super(key.hash)
  end
end
