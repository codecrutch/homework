#PHASE 1 == n^2
#PHASE 2 == n linear
require 'byebug'

def my_min(array)
  smallest = array.first

  array.each do |el|
    if el < smallest
      smallest = el
    end
  end

  smallest
end

#Phase I n^2
def lcss(arr)
  subs = []
  arr.each_with_index do |el,idx|
    arr.each_with_index do |el2,idx2|
      next if idx > idx2
      subs << arr[idx..idx2]
    end
  end
  subs.map { |sub| sub.inject(:+) }.max

end


# Phase II: n^1
def lcss2(arr)
  cgs = 0
  current = 0
  csn = nil

  arr.each do |el|
     if el > 0
       csn = nil
       break
     end

    if csn.nil? || csn < el
      csn = el
    end
  end
  return csn unless csn.nil?


  arr.each_with_index do |num, idx|
    if current < 0
      current = 0
    end

    current += num

    cgs = current if current > cgs
  end


  cgs
end
