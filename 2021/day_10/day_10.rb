input = IO.readlines("input")

chunk_types = { ']' => '[', ')' =>'(', '}' => '{', '>' => '<' }
error_scores = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25137 }
completion_scores = { '(' => 1, '[' => 2, '{' => 3, '<' => 4 }

illegal_chars, completions = [], []

input.each do |syntax|
  chunks = []
  invalid = false

  syntax.chars[0..-2].each do |char|
    if chunk_start = chunk_types[char]
      if chunks[-1] != chunk_start
        illegal_chars << char
        invalid = true
        break
      else
        chunks.pop
      end
    else
      chunks << char
    end
  end
  completions << chunks.reverse unless invalid
end

puts "Syntax error score: " + illegal_chars.sum { |char| error_scores[char] }.to_s

scores =
  completions.collect do |chunk_chars|
    chunk_chars.inject(0) do |score, char|
      score * 5 + completion_scores[char]
    end
  end

puts "Middle completion score: " + scores.sort[scores.size/2].to_s
