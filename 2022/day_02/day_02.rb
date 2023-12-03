points_lookup_part1 = {
	['A', 'X'] => 4,
	['A', 'Y'] => 8,
	['A', 'Z'] => 3,
	['B', 'X'] => 1,
	['B', 'Y'] => 5,
	['B', 'Z'] => 9,
	['C', 'X'] => 7,
	['C', 'Y'] => 2,
	['C', 'Z'] => 6,
}

points_lookup_part2 = {
	['A', 'X'] => 3, # R S
	['A', 'Y'] => 4, # R R
	['A', 'Z'] => 8, # R P
	['B', 'X'] => 1, # P R
	['B', 'Y'] => 5, # P P
	['B', 'Z'] => 9, # P S
	['C', 'X'] => 2, # S P
	['C', 'Y'] => 6, # S S
	['C', 'Z'] => 7, # S R
}

rounds = IO.readlines("input").collect { |input_line| input_line.split(" ").to_a }

puts "Part 1: " + rounds.collect { |round| points_lookup_part1[round] }.sum.to_s
puts "Part 2: " + rounds.collect { |round| points_lookup_part2[round] }.sum.to_s
