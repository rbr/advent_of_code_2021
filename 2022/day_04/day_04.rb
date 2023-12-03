pairs = IO.readlines("input").collect(&:strip).collect{ |comparison| comparison.split(',') }

pair_ranges = pairs.collect do |pair1, pair2|
  pair1 = Range.new(*pair1.split("-").collect(&:to_i))
  pair2 = Range.new(*pair2.split("-").collect(&:to_i))
  [pair1, pair2]
end

cover_count = pair_ranges.count { |range1, range2| range1.cover?(range2) || range2.cover?(range1) }
overlap_count = pair_ranges.count { |range1, range2| (range1.to_a & range2.to_a).any? }

puts "Part 1: " + cover_count.to_s
puts "Part 1: " + overlap_count.to_s
