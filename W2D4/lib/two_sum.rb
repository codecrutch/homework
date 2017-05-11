#time complexity: n^2
require 'byebug'
def bad_two_sum?(array,target)
  array.each_index do |start|
    array.each_index do |finish|
      next if start >= finish
      return true if array[start] + array[finish] == target
    end
  end
  false
end

#time complexity n log(n)
def okay_two_sum?(array,target)
  array = array.sort
  start,finish = 0, array.length - 1
  while start < finish
    # debugger
    case (array[start] + array[finish]) <=> target
    when -1
      start += 1
    when 0
     return true
    when 1
      finish -= 1
    end
  end
false
end

# n time complexity
def two_sum?(arr,target)
  sums = {}
  arr.each do |num|
    return true if sums[target - num]
    sums[num] = true
  end
  false
end
