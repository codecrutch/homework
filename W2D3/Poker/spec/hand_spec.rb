require 'hand'

describe Hand do
  subject(:hand) { Hand.new }
  let(:ace_of_spades) { double("ace of spades") }

  describe "#show" do
    it "should be an empty hand" do
      expect(hand.show).to eq([])
    end
  end

  describe "#accept_card" do
    it "should be add a card to the hand" do
      hand.accept_card(ace_of_spades)

      expect(hand.show).to include(ace_of_spades)
    end
  end

  describe "#discard_card" do
    context "with a full hand" do
      let(:two_of_spades) { double("two of spades") }
      let(:three_of_spades) { double("three of spades") }
      let(:four_of_spades) { double("four of spades") }
      let(:five_of_spades) { double("five of spades") }


      before(:each) do
        cards = [ ace_of_spades,two_of_spades,three_of_spades, four_of_spades, five_of_spades]
        cards.each {|card| hand.accept_card(card) }
      end

      it "should discard a card if its in the hand" do
        hand.discard_card(two_of_spades)
        expect(hand.show).to_not include(two_of_spades)
      end

      it "should return false if it tries to discard a nonexistent card" do
        expect(hand.discard_card(:wrong_card)).to be false
      end
    end
  end
end
