dots, folds = [], []

IO.readlines("input").each do |input_line|
	if input_line.start_with?('fold')
		folds << input_line.split(' ').last
	else
		dots << input_line[0..-2].split(',').collect(&:to_i) unless input_line.size == 1
	end
end

GRID_HEIGHT = dots.max_by { |x, y| y }[1]
GRID_WIDTH = dots.max_by { |x, y| x }[0]

@grid = Array.new(GRID_HEIGHT + 1) { Array.new(GRID_WIDTH + 1) }
dots.each { |x, y| @grid[y][x] = 1 }

def print_grid(max_x, max_y)
	@grid.each_with_index do |row, y|
    row.each_with_index do |_, x|
    	print @grid[y][x] || '.'
    	break if x > max_x
    end
    puts
    break if y > max_y
  end
end

folds.each_with_index do |fold, i|
	axis, line = fold.split('=')
	line = line.to_i

	if axis == 'y'
		@grid[line].each { |x| x = nil }

		((line+1)..GRID_HEIGHT).each do |y|
			@grid[y].each_with_index do |_, x|
				to_y = line - (y - line)
				next if @grid[y][x].nil?

				@grid[to_y][x] = @grid[y][x]
				@grid[y][x] = nil
			end
		end
	else
		@grid.each { |row| row[line] = nil }

		((line+1)..GRID_WIDTH).each do |x|
			(0..GRID_HEIGHT).each do |y|
				to_x = line - (x - line)
				next if @grid[y][x].nil?

				@grid[y][to_x] = @grid[y][x]
				@grid[y][x] = nil
			end
		end
	end

	puts "Dots visible after fold #{i}: " + @grid.sum { |row| row.compact.sum }.to_s
end

print_grid(40, 4)
