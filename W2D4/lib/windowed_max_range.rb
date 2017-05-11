def windowed_max_range(arr,w)
  cmr = nil
  arr.each_index do |i|
    # range = arr[i..w]
    # debugger
     break if (i + w) >= arr.length
    min = arr[i]
    max = arr[i + w-1]
    range = max - min
    if cmr.nil? || range > cmr
      cmr = range
    end
  end
  cmr
end
