require 'lru_cache'

describe LRUCache do
  subject(:cache) { LRUCache.new(4) }
  describe "#initialize" do
    it "should start with a size and empty hash" do
      expect(cache.count).to eq(0)
      expect(cache.instance_variable_get(:@size)).to eq(4)
    end
  end

  describe "#count" do
    it "should show the count" do
      cache.add("I walk the line")
      cache.add(5)

      expect(cache.count).to eq(2)
    end
  end

  describe "#show" do
    it "should show the least recently used" do
      cache.add([1,2,3])
      cache.add(5)
      cache.add(-5)
      cache.add({a: 1, b: 2, c: 3})
      cache.add([1,2,3,4])
      cache.add("I walk the line")
      cache.add(:ring_of_fire)
      cache.add("I walk the line")
      cache.add({a: 1, b: 2, c: 3})

      expect(cache.show).to eq([[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}])
    end
  end
end
