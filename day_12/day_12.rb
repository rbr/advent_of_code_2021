@cave_paths = IO.readlines("input").each_with_object({}) do |input_line, h|
	from, to = input_line[0..-2].split('-')
	h[from] ||= []
	h[from] << to
	h[to] ||= []
	h[to] << from
end

@paths = 0

def explore(cave, small_visited, small_twice, path)
	path = "#{path}-#{cave}"

	if cave == 'end'
		@paths += 1
		return
	end
	small_twice = true if small_visited.include?(cave)
	small_visited << cave if cave.downcase == cave

  options = @cave_paths[cave] || []
	options -= small_visited if small_twice

	options.each do |cave_option|
		next if cave_option == 'start'
		explore(cave_option, small_visited.dup, small_twice, path)
	end
end

explore('start', [], false, '')

puts @paths
