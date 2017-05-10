class Card
  attr_reader :suit, :symbol

  PRECEDENCE = %i[two three four five six seven
                  eight nine ten jack queen king ace]
  SUITS = %i[club diamond heart spade]

  def initialize(suit, symbol)
    @suit = suit
    @symbol = symbol
  end

  def ==(other_card)
    self.symbol == other_card.symbol
  end

  def <(other_card)
    PRECEDENCE.index(self.symbol) < PRECEDENCE.index(other_card.symbol)
  end

  def >(other_card)
    return false if self < other_card || self == other_card
    true
  end
end
