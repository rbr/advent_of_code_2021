input = IO.readlines("input")
count_uniq_values = 0
output_sum = 0

input.each do |input_line|
  signal_pattern, four_digit = input_line.split(' | ').collect { |input_part| input_part.split(' ') }
  count_uniq_values += four_digit.count { |digit| [2,3,4,7].include?(digit.size) }

  numbers = Array.new(10)
  numbers235, numbers069 = [], []

  signal_pattern.each do |signal|
    signal = signal.chars.sort.join

    case signal.size
    when 2 then numbers[1] = signal
    when 3 then numbers[7] = signal
    when 4 then numbers[4] = signal
    when 5 then numbers235 << signal
    when 6 then numbers069 << signal
    when 7 then numbers[8] = signal
    end
  end

  # Inital success
  # numbers[3] = numbers235.delete_at(numbers235.index { |n| (numbers[1].chars - n.chars).empty? })
  # numbers[6] = numbers069.delete_at(numbers069.index { |n| (numbers[1].chars - n.chars).any? })
  # top_right_segment = (numbers[4].chars - numbers[6].chars)[0]
  # numbers[5] = numbers235.delete_at(numbers235.index { |n| !n.chars.include?(top_right_segment) })
  # numbers[2] = numbers235[0]
  # bottom_left_segment = (numbers[6].chars - numbers[5].chars)[0]
  # numbers[9] = numbers069.delete_at(numbers069.index { |n| !n.chars.include?(bottom_left_segment) })
  # numbers[0] = numbers069[0]

  # Smarter success
  numbers[3] = numbers235.delete_at(numbers235.index { |n| (numbers[1].chars & n.chars).size == 2 })
  numbers[5] = numbers235.delete_at(numbers235.index { |n| (numbers[4].chars & n.chars).size == 3 })
  numbers[2] = numbers235[0]
  numbers[9] = numbers069.delete_at(numbers069.index { |n| (numbers[4].chars & n.chars).size == 4 })
  numbers[6] = numbers069.delete_at(numbers069.index { |n| (numbers[5].chars & n.chars).size == 5 })
  numbers[0] = numbers069[0]

  output_value =
    four_digit.collect do |digit|
      digit = digit.chars.sort.join
      numbers.index { |number| number == digit }.to_s
    end.join.to_i

  output_sum += output_value
end

puts "Uniq values: " + count_uniq_values.to_s
puts "Output sum: " + output_sum.to_s
