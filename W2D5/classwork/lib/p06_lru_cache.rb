require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'

class LRUCache
  attr_reader :count
  
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(@map[key])
    else
      eject! if count == @max
      val = calc!(key)
      link = @store.append(key, val)
      @map.set(key, link)
    end
    @store.last.val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    @prc.call(key)
  end

  def update_link!(link)
    link.remove
    @store.append(link.key, link.val)
  end

  def eject!
    link = @store.first
    link.remove
    @map.delete(link.key)
  end
end
