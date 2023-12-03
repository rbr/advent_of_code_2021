
def calculate_priorities(items)
  items.collect do |item|
    if item.upcase == item
      item.ord - 38
    else
      item.ord - 96
    end
  end
end

rucksacks = IO.readlines("input").collect do |input_line|
  mid = input_line.size / 2
  [input_line[0..(mid-1)], input_line[mid..-1]]
end

items = rucksacks.collect do |part1, part2|
  part1.chars & part2.chars
end.flatten

puts "Part 1: " + calculate_priorities(items).sum.to_s

items = IO.readlines("input").each_slice(3).collect do |group|
  (group[0].chars & group[1].chars & group[2].chars).first
end

puts "Part 2: " + calculate_priorities(items).sum.to_s
