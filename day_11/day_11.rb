input = IO.readlines("input")
MAP_HEIGHT = input.size
MAP_WIDTH = input[0].size - 1
@cavern = Array.new(MAP_HEIGHT)
@flashes = 0

input.each_with_index do |input_line, i|
  @cavern[i] = input_line.chars[0..-2].collect(&:to_i)
end

def trigger(y, x)
  @cavern[y][x] += 1
  return unless @cavern[y][x] == 10
  @flashes += 1

  trigger(y-1, x-1) if y > 0 && x > 0
  trigger(y-1,   x) if y > 0
  trigger(y-1, x+1) if y > 0 && x < MAP_WIDTH - 1
  trigger(y,   x+1) if x < MAP_WIDTH - 1
  trigger(y+1, x+1) if x < MAP_WIDTH - 1 && y < MAP_HEIGHT - 1
  trigger(y+1,   x) if y < MAP_HEIGHT - 1
  trigger(y+1, x-1) if x > 0 && y < MAP_HEIGHT - 1
  trigger(y,   x-1) if x > 0
end

500.times do |i|
  @cavern.each_with_index do |row, y|
    row.each_with_index do |height, x|
      trigger(y, x)
    end
  end

  puts "All flash @ step #{i+1}" if @cavern.flatten.all? { |octo| octo > 9 }

  @cavern.each_with_index do |row, y|
    row.each_with_index do |height, x|
      @cavern[y][x] = 0 if @cavern[y][x] > 9
    end
  end

  puts "Flashes after 100 steps: " + @flashes.to_s if i == 99
end

