require 'tdd'

describe "Test Driven Development" do
  context "TDD Problems" do
    describe "#uniq" do
      it "should take an array and return uniq elements" do
        arr = [1, 2, 1, 3, 3]
        expect(arr.my_uniq).to eq([1, 2, 3])
      end
    end

    describe "#two_sum" do
      it "should return all pairs of indexes where sum is equal to zero" do
        arr = [-1, 0, 2, -2, 1]

        expect(arr.two_sum).to eq([[0, 4], [2, 3]])
      end
    end

    describe "#my_transpose" do
      it "it should turn the rows into columns" do
        rows = [
          [0, 1, 2],
          [3, 4, 5],
          [6, 7, 8]
        ]
        cols = [
          [0, 3, 6],
          [1, 4, 7],
          [2, 5, 8]
        ]
        expect(rows.my_transpose).to eq(cols)
      end
    end
  end

  context "Stock Picker" do
    describe "#stock_picker" do
      it "should take an array" do
        expect { stock_picker }.to raise_error(ArgumentError)
      end

      it "should return nil if argument is not an array" do
        expect(stock_picker("Profitable")).to be_nil
      end

      context "when empty" do
        it "should return nil if passed one" do
          expect(stock_picker([])).to be_nil
        end
      end

      context "when passed more than one stock" do
        it "should return the indexes of that pair" do
          stock_prices = [50, 100]

          expect(stock_picker(stock_prices)).to eq([0,1])
        end

        it "should return the most profitable pair index" do
          stock_prices = [20, 76, 1, 144, 57]

          expect(stock_picker(stock_prices)).to eq([2,3])
        end
      end
    end
  end
end
