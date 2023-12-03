input = IO.readlines("input")[0].chars

process_count = 4

(3..(input.size)).each do |pos|
	break if input[(pos-3)..pos].uniq.size == 4
	process_count += 1
end

puts "Part 1: " + process_count.to_s

(13..(input.size)).each do |pos|
	break if input[(pos-13)..pos].uniq.size == 14
	process_count += 1
end

puts "Part 2: " + process_count.to_s
