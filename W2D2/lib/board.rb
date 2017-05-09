require 'byebug'

class Board
  class InvalidMove < StandardError; end
  attr_accessor :cups

  def initialize(name1, name2)
    @name1, @name2 = name1, name2
    @cups  = Array.new(14) { Array.new }
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_index do |idx|
      next if [6,13].include?(idx)
      @cups[idx] = %i(stone stone stone stone)
    end
  end

  def valid_move?(start_pos)
    if start_pos < 0 || start_pos > 12 || cups[start_pos].empty?
      raise InvalidMove, "Invalid starting cup"
    end
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos]
    @cups[start_pos] = []

    cup_idx = start_pos

    until stones.empty?
      cup_idx += 1
      cup_idx = 0 if cup_idx > 13

      if cup_idx.eql?(6)
        cups[cup_idx] << stones.pop if current_player_name == @name1
      elsif cup_idx.eql?(13)
        cups[cup_idx] << stones.pop if current_player_name == @name2
      else
        cups[cup_idx] << stones.pop
      end
    end

    render

    next_turn(cup_idx)
  end

  def next_turn(ending_cup_idx)
    return :prompt if [6,13].include?(ending_cup_idx)
    return :switch if cups[ending_cup_idx].count == 1
    return ending_cup_idx if cups[ending_cup_idx].any?
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    cups.take(6).all? {|cup| cup.empty? } ||
    cups[7..12].all? {|cup| cup.empty? }
  end

  def winner
    case cups[6] <=> cups[13]
    when -1
      @name2
    when 0
      :draw
    when 1
      @name1
    end
  end
end
