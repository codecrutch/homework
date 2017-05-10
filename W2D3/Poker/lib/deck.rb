require_relative 'card'

class Deck

  def initialize
    @cards = new_deck
  end

  def shuffle!
    @cards.shuffle!
  end

  def get_card
    @cards.pop
  end

  private

  def new_deck
    deck = []
    Card::SUITS.each do |suit|
      Card::PRECEDENCE.each do |rank|
        deck << Card.new(suit, rank)
      end
    end
    deck
  end

end
