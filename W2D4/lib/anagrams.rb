require 'byebug'
# Worst possible combinatorial algorithm
def first_anagram?(str,ana)
  result = []

  fact = (1..str.chars.length).inject(:*)

  until result.length >= fact
    word = str.chars.shuffle.join
    result << word unless result.include?(word)
  end

  result.include?(ana)
end

# n^2 algorithm
def second_anagram?(str,ana)
  return false if str.length != ana.length
  # debugger if str == "applesauce"
  ((str.length-1).downto(0)).each do |idx1|
    next if str[idx1].nil? || ana[idx1].nil?
      str.delete!(str[idx1])
      ana.delete!(ana[idx1])
  end

  ana.empty? && str.empty?
end


def third_anagram?(str,ana)
  str.chars.sort == ana.chars.sort
end

def fourth_anagram?(str,ana)
  str_hash = Hash.new(0)

  (0...str.length).each do |idx|
    str_hash[str[idx]] += 1
    str_hash[str[idx]] -= 1
  end

  str_hash.each do |k,v|
    return false unless str_hash[k] == 0
  end

  true
end
