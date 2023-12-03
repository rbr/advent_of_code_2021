require "set"

require 'benchmark'
time = Benchmark.measure {

cave = IO.readlines("input").collect { |line| line.strip.chars.collect(&:to_i) }

def explore(cave)
  cave_exit = [cave.size - 1, cave[0].size - 1]

  location_risks = Hash.new(Float::INFINITY)
  location_risks[[0, 0]] = 0

  to_explore = [[0, 0]]
  explored = Set[]

  while to_explore.any?
    pos_y, pos_x = to_explore.shift
    current_risk = location_risks[[pos_y, pos_x]]
    explored.add([pos_y,pos_x])

    [
      [pos_y - 1, pos_x],
      [pos_y, pos_x + 1],
      [pos_y + 1, pos_x],
      [pos_y, pos_x - 1],
    ].each do |y, x|
      next if y < 0 || x < 0 || y > cave_exit[0] || x > cave_exit[1]

      neighbour_risk = current_risk + cave[y][x]

      next if location_risks[[y, x]] <= neighbour_risk
      location_risks[[y, x]] = neighbour_risk

      next if explored.include?([y,x])
      to_explore << [y, x]
    end
  end

  puts location_risks[cave_exit]
end

explore(cave)

real_cave =
  Array.new(cave.size * 5) do |y|
    Array.new(cave[0].size * 5) do |x|
      repeat_risk = cave[y % cave.size][x % cave[0].size]
      (repeat_risk + y/cave.length + x/cave[0].length - 1) % 9 + 1
    end
  end

explore(real_cave)

}
puts time
