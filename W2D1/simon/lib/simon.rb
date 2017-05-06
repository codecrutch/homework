class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize(seq = [])
    @seq = seq
    @sequence_length = 1
    @game_over = false
  end

  def play
    until game_over
      take_turn
    end

    game_over_message
    reset_game
  end

  def take_turn
    puts "Remember this sequence!"
    sleep(0.8)
    system("clear")


    show_sequence
    require_sequence

    unless game_over
      round_success_message
      self.sequence_length += 1
      sleep(1)
    end
  end

  def show_sequence
    add_random_color
    seq.each do |color|
      puts color
      sleep 0.75
      system("clear")
      sleep(0.25)
    end
  end

  def require_sequence
    puts "Enter the last sequence!"
    input = gets.chomp
    if input != seq.join(" ")
      self.game_over = true
    end
  end

  def add_random_color
    seq << COLORS.sample
  end

  def round_success_message
    puts "You've survived round #{sequence_length}"
  end

  def game_over_message
    puts "Game over"
  end

  def reset_game
    self.sequence_length = 1
    self.seq = []
    self.game_over = false
  end
end

if __FILE__ == $PROGRAM_NAME
  simon = Simon.new
  simon.play
end
