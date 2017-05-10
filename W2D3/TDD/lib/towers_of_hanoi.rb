class TowersOfHanoi
  attr_reader :board
  WINNING_BOARDS = [ [[],[],[1, 2, 3]], [[],[1, 2, 3],[]] ]

  def initialize
    @board = populate
  end

  def move(start, finish)
    @board[finish].unshift( @board[start].shift ) if valid_move?(start, finish)
    @board
  end

  def won?
    WINNING_BOARDS.include?(@board)
  end

  private

  def populate
    [[1, 2, 3], [], []]
  end

  def valid_move?(start, finish)
    return false unless start.between?(0, 2) && finish.between?(0, 2)
    from = @board[start]
    to = @board[finish]
    raise InvalidMove.new("There's nothing to move here") if from.empty?
    unless to.empty?
      raise InvalidMove.new("Can't balance") if from.first > to.first
    end
    true
  end


end

class InvalidMove < StandardError
end
