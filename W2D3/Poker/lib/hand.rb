#calculate what hand we have (2 of a kind, flush etc)
#Logic of which hand beats another
class Hand

  def initialize
    @hand = []
  end

  def show
    @hand.dup
  end

  def accept_card(card)
    @hand << card
  end

  def discard_card(card)
    @hand.include?(card) ? @hand.delete(card) : false
  end

end
