def sluggish_oct(arr)

  arr.each_with_index do |el1, idx1|
    longest = el1
    arr.each_with_index do |el2, idx2|
      if el1.length < el2.length
        longest = el2
      end
    end
    return longest if longest == el1
  end

end

def dominant_octopus(arr)
  prc = Proc.new { |a,b| a.length <=> b.length }
  merge_sort(arr, &prc)[-1]
end

def merge_sort(arr, &prc)
  return arr if arr.length <= 1

  prc ||= Proc.new { |a,b| a <=> b }

  mid_idx = arr.length / 2
  left = arr.dup.take(mid_idx)
  right = arr.dup.drop(mid_idx)

  merge(merge_sort(left, &prc), merge_sort(right, &prc), &prc)
end

def merge(left, right, &prc)
  temp_arr = []

  until left.empty? || right.empty?
    if prc.call(left.first, right.first) == -1
      temp_arr << left.shift
    else
      temp_arr << right.shift
    end
  end

  temp_arr + left + right
end

def clever_octopus(arr)
  longest = ""

  arr.each { |el| longest = el if el.length > longest.length}
  longest

end

arr = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']

p sluggish_oct(arr)
p dominant_octopus(arr)
p clever_octopus(arr)

def slow_dance(pos, arr)
  arr.each_with_index { |el, idx| return idx if el == pos }
  nil
end

def fast_dance(pos, hash)
  hash[pos]
end

tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
p slow_dance("up", tiles_array)
p slow_dance("right-down", tiles_array)

tiles_hash = {
  "up" => 0,
  "right-up" => 1,
  "right" => 2,
  "right-down" => 3,
  "down" => 4,
  "left-down" => 5,
  "left" => 6,
  "left-up" => 7
}

p fast_dance("up", tiles_hash)
p fast_dance("right-down", tiles_hash)
