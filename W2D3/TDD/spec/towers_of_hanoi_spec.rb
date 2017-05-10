require 'towers_of_hanoi'

describe TowersOfHanoi do
  subject(:game) { TowersOfHanoi.new }
  context "Towers of Hanoi" do
    it "should have board with 3 towers" do
      expect(game.board).to eq([[1, 2, 3],[],[]])
    end

    describe "#move" do
      context "with a valid move" do
        it "should move a piece" do
          expect(game.move(0, 2)).to eq([[2, 3],[],[1]])
        end

        it "should check for a valid move" do
          expect(game).to receive(:valid_move?).with(0, 1).and_return(true)
          game.move(0, 1)
        end

      end

      context "with invalid move" do
        it "should check for invalid move" do
          expect(game.move(0, 4)).to eq([[1, 2, 3],[],[]])
        end

        it "should only place smaller rocks on bigger rocks" do
          game.move(0, 1)
          expect { game.move(0, 1) }.to raise_error(InvalidMove)
        end
      end
    end

    describe "#won?" do
      context "if game is over" do
        it "should check to see if tower is complete" do
          game.move 0, 1
          game.move 0, 2
          game.move 1, 2
          game.move 0, 1
          game.move 2, 0
          game.move 2, 1
          game.move 0, 1

          expect(game.won?).to be true
        end
      end
    end



  end
end
