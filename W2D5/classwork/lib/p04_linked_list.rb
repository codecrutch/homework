class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    return nil if @prev == nil || @next == nil
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable

  attr_reader :head, :tail

  def initialize
    @head = Link.new(:head)
    @tail = Link.new(:tail)
    @head.prev = nil
    @head.next = @tail
    @tail.prev = @head
    @tail.next = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each { |node| return node.val if node.key == key }
  end

  def include?(key)
    any? { |node| node.key == key}
  end

  def append(key, val)
    new_node = Link.new(key, val)
    last_node = @tail.prev
    last_node.next = new_node
    new_node.next = @tail
    @tail.prev = new_node
    new_node.prev = last_node
    new_node
  end

  def update(key, val)
    each {|node| node.val = val if node.key == key}
  end

  def remove(key)
    get_node(key).remove
  end

  def each(&prc)
    current_node = @head

    until current_node == @tail
      prc.call(current_node) unless current_node == @head
      current_node = current_node.next
    end

    nil
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

  private
  def get_node(key)
    each { |node| return node if node.key == key }
  end
end
