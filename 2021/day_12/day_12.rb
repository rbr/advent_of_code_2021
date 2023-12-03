@cave_paths = IO.readlines("input").each_with_object({}) do |input_line, h|
	from, to = input_line[0..-2].split('-')
	h[from] ||= []
	h[from] << to
	h[to] ||= []
	h[to] << from
end

def explore(cave, small_visited, small_twice)
	return 1 if cave == 'end'

	small_twice = true if small_visited.include?(cave)
	small_visited << cave if cave.downcase == cave

  options = @cave_paths[cave] || []
	options -= small_visited if small_twice

	options.collect do |cave_option|
		next if cave_option == 'start'
		explore(cave_option, small_visited.dup, small_twice)
	end.compact.sum
end

puts "Paths with single small visits: " + explore('start', [], true).to_s
puts "Paths with single double small visit: " + explore('start', [], false).to_s
