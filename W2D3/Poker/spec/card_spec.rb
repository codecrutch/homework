require 'card'

describe Card do
  subject(:ace) { Card.new(:spade, :ace) }
  let(:king) { Card.new(:club, :king) }
  let(:duece) { Card.new(:heart, :two) }

  it "should have a suit" do
    expect(ace.suit).to eq(:spade)
  end

  it "should have a symbol" do
    expect(ace.symbol).to eq(:ace)
  end

  describe "#==" do

    it "should not be equal" do
      expect(king == duece).to be false
    end

    it "should be equal" do
      expect(king == king.dup).to be true
    end
  end

  describe "#<" do
    it "should return false when greater than another" do
      expect(king < duece).to be false
    end

    it "should return true when less than another" do
      expect(duece < king).to be true
    end
  end

  describe "#>" do
    it "should return true when greater than another" do
      expect(king > duece).to be true
    end

    it "should return false when less than another" do
      expect(duece > king).to be false
    end
  end
end
