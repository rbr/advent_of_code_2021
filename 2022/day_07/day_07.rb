input = IO.readlines("input")

dirs = { 'root' => 0 }
current_dir = ['root']
index = 1

while index < input.size do
  command = input[index]

  case command
  when /cd [a-z]+/
    current_dir.push(command[5..-2])

  when /cd ../
    current_dir.pop

  when /ls/
    content = []
    while input[index + 1][0] != '$' do
      index += 1
      content << input[index]
      break if index+1 == input.size
    end

    dir_size = content.collect { |c| c.split(' ')[0].to_i }.sum

    inside_dirs = {}
    current_dir.each_with_index { |dir, i| inside_dirs[current_dir[0..i].join('/')] = dir_size }
    dirs.merge!(inside_dirs) { |k, old_value, add_value| old_value + add_value }

  else
    fail "Unknown command: #{command}"

  end

  index += 1
end

puts "Part 1: " + dirs.values.select { |size| size <= 100_000 }.sum.to_s

total = 70_000_000
needed = 30_000_000
available = total - dirs.values[0]

puts "Part 2: " + dirs.values.select { |size| available + size >= needed }.min.to_s
