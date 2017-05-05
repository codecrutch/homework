class Queue
  attr_accessor :queue

  def initialize
    @queue = []
  end

  def enqueue(el)
    queue << el
    el
  end

  def dequeue
    queue.shift
  end

  def show
    queue
  end
end

class Stack
  attr_accessor :stack

  def initialize
    @stack = []
  end

  def add(el)
    stack << el
    el
  end

  def remove
    stack.pop
  end

  def show
    stack
  end
end

class Map
  attr_accessor :map

  def initialize(keys = nil, values = nil)
    @keys = keys
    @values = values

    if keys && values
      merge_keys_and_values
    end
  end

  alias_method :show, :map

  def assign(key, value)
    if lookup(key)
      remove(key) && assign(key, value)
    else
      map << [key, value]
    end
  end

  def lookup(key)
    map.select {|(map_key, _)| key == map_key }.first
  end

  def remove(key)
    map.delete_if {|(map_key, _)| key == map_key }
  end

  private

  attr_reader :keys, :values

  def merge_keys_and_values
    self.map = keys.zip(values)
  end
end
