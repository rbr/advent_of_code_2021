input = IO.readlines("input")

# Dumbly done part 1

school = input[0].split(',').collect(&:to_i)

80.times do
  new_gen_count = 0
  school.each_with_index do |timer, i|
    if school[i] == 0
      school[i] = 6
      new_gen_count += 1
    else
      school[i] -= 1
    end
  end
  school.append(*Array.new(new_gen_count) { 8 })
end

puts "Fish count gen 80: " + school.count.to_s

# Smarter done part 2

school_hash = input[0].split(',').collect(&:to_i).tally

256.times do
  # puts school_hash
  school_hash_new_gen = {}

  1.upto(8).each { |i| school_hash_new_gen[i-1] = school_hash[i] }
  school_hash_new_gen[6] = school_hash_new_gen[6].to_i + school_hash[0].to_i
  school_hash_new_gen[8] = school_hash[0]

  school_hash = school_hash_new_gen
end

puts "Fish count gen 256: " + school_hash.values.compact.sum.to_s
