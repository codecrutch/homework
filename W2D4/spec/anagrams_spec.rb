require "anagrams"

describe "#first_anagram?" do
  subject(:str) { "cat" }
  let (:ana) { "act" }
  it "should generate and store all possible anagrams of the string" do
    expect(first_anagram?(str,ana)).to be true
  end

end

describe "#second_anagram?" do
  subject(:str) { "cat" }
  let (:ana) { "act" }

  it "should generate and store all possible anagrams of the string" do
    expect(second_anagram?(str,ana)).to be true
  end

  it "takes a longer word" do
    expect(second_anagram?("applesauce", "ppalesauce")).to be true
  end
end

describe "#third_anagram?" do
  subject(:str) { "cat" }
  let (:ana) { "act" }

  it "should generate and store all possible anagrams of the string" do
    expect(third_anagram?(str,ana)).to be true
  end

  it "takes a longer word" do
    expect(third_anagram?("applesauce", "ppalesauce")).to be true
  end
end

describe "#fourth_anagram?" do
  subject(:str) { "cat" }
  let (:ana) { "act" }

  it "should generate and store all possible anagrams of the string" do
    expect(fourth_anagram?(str,ana)).to be true
  end

  it "takes a longer word" do
    expect(fourth_anagram?("applesauce", "ppalesauce")).to be true
  end
end
