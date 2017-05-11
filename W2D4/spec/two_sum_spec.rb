require "two_sum"

describe "#bad_two_sum?" do
    subject(:arr) { [0,1,5,7] }
  it "determines whether two integers sum to target" do
    expect(bad_two_sum?(arr,6)).to be true

    expect(bad_two_sum?(arr,10)).to be false
  end
end

describe "#okay_two_sum?" do
    subject(:arr) { [0,1,5,7] }
  it "determines whether two integers sum to target" do
    expect(okay_two_sum?(arr,6)).to be true

    expect(okay_two_sum?(arr,10)).to be false
  end
end

describe "#two_sum?" do
    subject(:arr) { [0,1,5,7] }
  it "determines whether two integers sum to target" do
    expect(two_sum?(arr,6)).to be true

    expect(two_sum?(arr,10)).to be false
  end
end
