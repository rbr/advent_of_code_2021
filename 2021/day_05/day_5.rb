allow_diagonal = true
grid = Array.new(1000) { Array.new(1000) { 0 }}

IO.readlines("input").each do |input_line|
  line = input_line.split(' -> ').collect { |coordinates| coordinates.split(',').collect(&:to_i) }

  # [[[217,490],[217,764], ...]
  # line[start = 0 / end = 1][x = 0 / y = 1]

  if line[0][0] == line[1][0]

    x = line[0][0]
    ys = [line[0][1],line[1][1]]
    (ys.min..ys.max).each { |y| grid[x][y] += 1 }

  elsif line[0][1] == line[1][1]

    y = line[0][1]
    xs = [line[0][0],line[1][0]]
    (xs.min..xs.max).each { |x| grid[x][y] += 1 }

  elsif allow_diagonal
    direction = case
      when line[0][0] < line[1][0] && line[0][1] > line[1][1] then 1 # ./ x+ y-
      when line[0][0] > line[1][0] && line[0][1] < line[1][1] then 2 # /' x- y+
      when line[0][0] < line[1][0] && line[0][1] < line[1][1] then 3 # '\ x+ y+
      when line[0][0] > line[1][0] && line[0][1] > line[1][1] then 4 # \. x- y-
    end

    x, y = line[0]
    grid[x][y] += 1

    while [x, y] != line[1]
      case direction
      when 1 then x += 1; y -= 1
      when 2 then x -= 1; y += 1
      when 3 then x += 1; y += 1
      when 4 then x -= 1; y -= 1
      end
      grid[x][y] += 1
    end
  end
end

puts "Overlapping points: " + grid.sum { |column| column.count { |point| point > 1 }  }.to_s
