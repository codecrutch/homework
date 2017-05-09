require 'byebug'

class PolyTreeNode
  attr_reader :value, :parent
  attr_accessor :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    if @parent.nil?
      @parent = node
      @parent.children << self
    else
      @parent.children.delete(self)
      @parent = node
      unless @parent.nil?
        @parent.children << self
      end
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    child_node.parent = nil
  end

  def inspect
    "#{self.value}: children #{self.children.map(&:value)}"
  end

  def dfs(target_value)
    return self if value == target_value

    #go through children array
    #if there are no children return nil
    #else keep iterating
    #if it doesn't find any children we need to return nil

    i = 0
      while i < children.length
        node = children[i].dfs(target_value)
        i += 1

        if node
          break if node.value == target_value
        end

      end
    node
  end

  def bfs(target_value)
    # Insert first self into the queue
    # Shift a node from queue
    # Check too see if value == target_value and return if true
    # if not, add that nodes children to queue
    # return nil if queue.empty?

    que = [self]

    until que.empty?
      current_node = que.shift
      return current_node if current_node.value == target_value
      current_node.children.each {|child| que << child }
    end

  end
end

class KnightPathFinder
  #store tree (build new tree)
  #store an array of positions that represent the spaces around the object
  # called grid directions
  #constant or hash with left => dir to left



  def initialize(starting_pos)
    @starting_pos = starting_pos
    @visited_positions = []
  end

  def new_move_positions(pos)
    new_move_positions = KnightPathFinder.valid_moves(pos).reject do |position|
      @visited_positions.include?(position)
    end
    @visited_positions += new_move_positions
    new_move_positions
  end

  def self.valid_moves(pos)
    moves = [[-2,-1],[-2,1],[2,-1],[2,1],[-1,-2],[-1,2],[1,-2],[1,2]].map do |position|
      [position[0] + pos.first, position[1] + pos.last]
    end
    moves.reject do |(row,col)|
      row < 0 || row > 7 || col < 0 || col > 7 || row < pos.first
    end
  end

  def build_move_tree
    root = PolyTreeNode.new(@starting_pos)
    queue = [root]
    until queue.empty?
      current_node = queue.shift
      moveable_positions = new_move_positions(current_node.value)

      moveable_positions.each do |pos|
        new_node = PolyTreeNode.new(pos)
        current_node.add_child(new_node)
        queue << new_node
      end
    end
    root
  end

  def find_path(end_pos)
    root = build_move_tree
    dest = root.bfs(end_pos)

    trace_path_back(dest)
  end

  def trace_path_back(end_root)
    path = []
    current_node = end_root

    until current_node.parent.nil?
      path.unshift(current_node.value)
      current_node = current_node.parent
    end

    path.unshift(@starting_pos)
  end









end
