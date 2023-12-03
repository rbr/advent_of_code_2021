#         [C] [B] [H]
# [W]     [D] [J] [Q] [B]
# [P] [F] [Z] [F] [B] [L]
# [G] [Z] [N] [P] [J] [S] [V]
# [Z] [C] [H] [Z] [G] [T] [Z]     [C]
# [V] [B] [M] [M] [C] [Q] [C] [G] [H]
# [S] [V] [L] [D] [F] [F] [G] [L] [F]
# [B] [J] [V] [L] [V] [G] [L] [N] [J]
#  1   2   3   4   5   6   7   8   9

stacks = {
  '1': %w[W P G Z V S B],
  '2': %w[F Z C B V J],
  '3': %w[C D Z N H M L V],
  '4': %w[B J F P Z M D L],
  '5': %w[H Q B J G C F V],
  '6': %w[B L S T Q F G],
  '7': %w[V Z C G L],
  '8': %w[G L N],
  '9': %w[C H F J],
}

moves = IO.readlines("input")[10..-1].collect do |move|
  move.split(' ').select.with_index { |_, i| [1,3,5].include?(i) }
end

moves.each do |move|
  count, src, dst = move
  count.to_i.times { stacks[dst.to_sym].prepend(stacks[src.to_sym].delete_at(0)) }
end

puts "Part 1: " + stacks.collect { |_,v| v[0] }.join

stacks = {
  '1': %w[W P G Z V S B],
  '2': %w[F Z C B V J],
  '3': %w[C D Z N H M L V],
  '4': %w[B J F P Z M D L],
  '5': %w[H Q B J G C F V],
  '6': %w[B L S T Q F G],
  '7': %w[V Z C G L],
  '8': %w[G L N],
  '9': %w[C H F J],
}

moves.each do |move|
  count, src, dst = move
  stacks[dst.to_sym].prepend(*stacks[src.to_sym].slice!(0,count.to_i))
end

puts "Part 2: " + stacks.collect { |_,v| v[0] }.join
