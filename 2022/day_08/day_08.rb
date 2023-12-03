grid = []

IO.readlines("input", chomp: true).each do |line|
  grid.push(line.split('').map(&:to_i))
end

visible, x, y = 0, 0, 0

while x < grid[0].size && y < grid.size do
  if y < grid.size - 1
    y += 1
  else
    y = 0
    x += 1
  end

  if x == 0 || x == grid[0].size - 1 || y == 0  || y == grid.size - 1
    visible += 1
  else
    tree_height = grid[y][x]
    row = grid[y]
    column = grid.collect { |row| row[x] }

    if tree_height > row[0..x-1].max || tree_height > row[x+1..row.size].max
      visible += 1
    elsif tree_height > column[0..y-1].max || tree_height > column[y+1..column.size].max
      visible += 1
    end
  end
end

puts "Part 1: " + visible.to_s
