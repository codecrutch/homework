require 'windowed_max_range'

describe "#windowed_max_range" do
  subject(:arr) {[1,0,2,5,4,8]}
  let(:arr2) {[1,3,2,5,4,8]}
  it "should return the largest range within an array" do
    expect(windowed_max_range(arr,2)).to eq(4)
    expect(windowed_max_range(arr,3)).to eq(5)
    expect(windowed_max_range(arr,4)).to eq(6)
    expect(windowed_max_range(arr2,5)).to eq(6)
  end
end
