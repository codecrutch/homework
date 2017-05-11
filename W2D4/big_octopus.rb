# quadratic
def sluggish_octopus
  fishes = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
  longest_fish = fishes.first
  fishes.each_with_index do |fish_one, start|
    fishes.each_with_index do |fish_two,finish|
      next if start >= finish
      if fish_two.length >= fish_one.length
        longest_fish = fish_two
      end
    end
  end

  longest_fish
end

class Array
  def merge_sort(&prc)
    return self if self.length <= 1
    prc ||= Proc.new {|x,y| x <=> y }

    midpoint = self.length / 2

    sorted_left = take(midpoint).merge_sort(&prc)
    sorted_right = drop(midpoint).merge_sort(&prc)

    Array.merge(sorted_left, sorted_right, &prc)
  end

  def self.merge(left, right, &prc)
    sorted = []

    until left.empty? || right.empty?
      case prc.call(left.first, right.first)
      when -1..0
        sorted << left.shift
      when 1
        sorted << right.shift
      end
    end

    sorted.concat(left)
    sorted.concat(right)

    sorted
  end
end

# 0(n log n)
def n_log_n_biggest_fish(fishes)
  fishes.merge_sort {|x,y| y.length <=> x.length }.first
end

def linear_fish_find(fishes)
  largest = fishes.first

  fishes.each_with_index do |fish, idx|
    next if idx == 0
    largest = fish.length > largest.length ? fish : largest
  end

  largest
end

def slow_dance(direction, moves)
  moves.each_with_index do |move,idx|
    return idx if direction == move
  end
end

def fast_dance(direction, moves)
  moves[direction]
end

tiles_hash = {
    "up" => 0,
    "right-up" => 1,
    "right"=> 2,
    "right-down" => 3,
    "down" => 4,
    "left-down" => 5,
    "left" => 6,
    "left-up" => 7
}

fish = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

p sluggish_octopus
p n_log_n_biggest_fish(fish)
p linear_fish_find(fish)
p slow_dance("right-down",tiles_array)
p fast_dance("left-down", tiles_hash)
