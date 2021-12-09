input = IO.readlines("input")
positions = input[0].split(',').collect(&:to_i)
positions.sort!

median = positions[positions.size / 2]
puts "Fuel part 1: " + positions.sum { |i| (median - i).abs }.to_s

average = (positions.sum / positions.size).round
puts "Fuel part 2: " + positions.sum { |i| (1..(average - i).abs).sum }.to_s
