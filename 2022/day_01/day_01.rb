elfs = IO.readlines("input").collect(&:to_i).chunk { |x| !x.zero? }.collect { |elf| elf[1].sum if elf[0] }.compact

puts "Part 1: " + elfs.max.to_s
puts "Part 1: " + elfs.sort.last(3).sum.to_s
