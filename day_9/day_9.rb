input = IO.readlines("input")
MAP_HEIGHT = input.size
MAP_WIDTH = input[0].size
heightmap = Array.new(MAP_HEIGHT)
lowpoint_sum = 0

input.each_with_index do |input_line, i|
  heightmap[i] = input_line.chars[0..-2].collect(&:to_i)
end

heightmap.each_with_index do |row, y|
  row.each_with_index do |height, x|
    next if height == 9

    adjacent_heights =
      [
        (heightmap[y-1][x] if y > 0),
        (heightmap[y+1][x] if y < MAP_HEIGHT - 1),
        (heightmap[y][x-1] if x > 0),
        (heightmap[y][x+1] if x < MAP_WIDTH - 1)
      ].compact

    if adjacent_heights.all? { |h| h > height }
      lowpoint_sum += height + 1
    end
  end
end

puts "Lowpoint sum: " + lowpoint_sum.to_s

@basins = []
@current_basin = 0
@heightmap = heightmap

def check_around(y, x)
  return if [9, nil].include?(@heightmap[y][x])

  @basins[@current_basin] += 1
  @heightmap[y][x] = nil

  check_around(y-1, x) if y > 0
  check_around(y+1, x) if y < MAP_HEIGHT - 1
  check_around(y, x-1) if x > 0
  check_around(y, x+1) if x < MAP_WIDTH - 1
end

@heightmap.each_with_index do |row, y|
  row.each_with_index do |height, x|
    next if [9, nil].include?(height)

    @basins[@current_basin] = 0
    check_around(y, x)
    @current_basin += 1
  end
end

puts "Largest basins product: " + @basins.sort[-3..-1].inject(:*)
