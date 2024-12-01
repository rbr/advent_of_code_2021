left_list, right_list = [], []

File.foreach('day_01_input.txt') do |line|
  values = line.split.map(&:to_i)
  left_list << values[0]
  right_list << values[1]
end

left_list.sort!
right_list.sort!

fail('ho ho ho') if left_list.size != right_list.size

total_distance = 0

left_list.size.times do |i|
  total_distance += (left_list[i] - right_list[i]).abs
end 

puts "Part 1: #{total_distance}"

right_counted = right_list.each_with_object(Hash.new(0)) do |number, hash|
  hash[number] += 1
end

total_distance = 0

left_list.each do |number|
  total_distance += number * right_counted[number]
end

puts right_counted
puts "Part 2: #{total_distance}"