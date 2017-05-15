# class Fixnum
#   # Fixnum#hash already implemented for you
# end
#
# class Array
#   def hash
#     # if self == [[]]
#     #   return -1 #to pass [[]] spec
#     # end
#     total = 0
#
#     each.with_index do |el, i|
#       total += el.hash + i.hash
#     end.reduce(:+)
#
#     total
#   end
# end
#
# class String
#   def hash
#     chars.map do |el|
#       el.ord.hash
#     end.reduce(:+)
#   end
# end
#
# class Hash
#   # This returns 0 because rspec will break if it returns nil
#   # Make sure to implement an actual Hash#hash method
#   def hash
#     result = []
#
#     each do |key, val|
#       result << key.to_s.hash << val.hash
#     end
#
#     result.sort.join.to_i
#   end
# end
