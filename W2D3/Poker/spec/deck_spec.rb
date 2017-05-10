require 'deck'

describe Deck do
  subject(:deck) { Deck.new }
  let(:all_cards) { deck.instance_variable_get(:@cards) }
  it "should have 52 cards" do
    expect(all_cards.length).to eq(52)
  end

  describe "#shuffle!" do
    it "should shuffle the deck" do
      first = all_cards.first
      first_card = [first.symbol, first.suit]
      deck.shuffle!
      after_shuffle = [all_cards.first.symbol, all_cards.first.suit]
      expect(first_card).to_not eq(after_shuffle)
    end
  end

  describe "#get_card" do
    it "should should return and remove 1 card from the deck" do
      expect(deck.get_card).to be_instance_of(Card)
    end
  end
end
