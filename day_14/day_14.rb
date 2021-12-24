polymer = IO.readlines("input")[0].strip.chars
pair_insertions = IO.readlines("input")[2..-1].collect { |i| i.strip.split(' -> ') }.to_h

pairs = polymer.each_cons(2).collect { |p| p.join }.tally
element_counts = Hash.new(0).merge(polymer.tally)

40.times do |i|
	pairs_new = Hash.new(0)

	pairs.each do |pair, count|
		unless insert = pair_insertions[pair]
			pairs_new[pair] += count
			next
		end

		new_pair_1 = pair[0] + insert
		new_pair_2 = insert + pair[1]

		pairs_new[new_pair_1] += count
		pairs_new[new_pair_2] += count

		element_counts[insert] += count
	end

	puts element_counts.values.minmax.reduce(:-).abs if [10,40].include?(i+1)
	pairs = pairs_new
end
