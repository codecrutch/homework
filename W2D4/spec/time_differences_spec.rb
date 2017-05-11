require 'time_differences'

describe "#my_min" do
  subject(:arr) { [ 0, 3, 5, 4, -5, 10, 1, 90 ] }
  it "should return smallest int" do
    expect(my_min(arr)).to eq(-5)
  end
end


describe "lcss " do
  context "Phase I: n^2" do
    subject(:array) {[5,3,-7]}
    it "largest sub_sum" do
      expect(lcss(array)).to eq(8)
    end

    let (:arr) {[2, 3, -6, 7, -6, 7]}
    it "largest sub_sum" do
      expect(lcss(arr)).to eq(8)
    end

    let (:arr3) {[-5,-1,-3]}
    it "largest sub_sum" do
      expect(lcss(arr3)).to eq(-1)
    end
  end
end

describe "lcss " do
  context "Phase II: n" do
    subject(:array) {[5,3,-7]}
    it "largest sub_sum" do
      expect(lcss2(array)).to eq(8)
    end

    let (:arr) {[2, 3, -6, 7, -6, 7]}
    it "largest sub_sum" do
      expect(lcss2(arr)).to eq(8)
    end

    let (:arr3) {[-5,-1,-3]}
    it "largest sub_sum" do
      expect(lcss2(arr3)).to eq(-1)
    end
  end
end
