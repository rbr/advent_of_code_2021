class BingoBoard
  attr_accessor :board

  def initialize(number_arrays)
    @board = number_arrays.collect do |row|
      row.split(' ').collect do |num|
        BingoNumber.new(num.to_i)
      end
    end
  end

  def mark_number(number_called)
    @board.each do |row|
      row.each do |bingo_number|
        bingo_number.mark! if bingo_number.number == number_called
      end
    end
  end

  def won?
    horizontal_win = @board.any? { |row| row.all? { |bingo_number| bingo_number.marked? } }
    vertical_win = @board.transpose.any? { |row| row.all? { |bingo_number| bingo_number.marked? } }

    horizontal_win || vertical_win
  end

  def sum_unmarked
    unmarked = @board.collect { |row| row.collect { |bingo_number| bingo_number.number if !bingo_number.marked? } }
    unmarked.flatten.compact.sum
  end

  def debug
    @board.each { |row| puts row.collect { |bingo_number| bingo_number.debug }.join(' ') }
  end
end

class BingoNumber
  attr_accessor :number, :marked

  def initialize(value)
    @number = value
    @marked = false
  end

  def mark!
    @marked = true
  end

  def marked?
    @marked
  end

  def debug
    number.to_s.rjust(2, "0") + ' ' + (marked? ? '!' : ' ')
  end
end

input = IO.readlines("input")
numbers_drawn = input[0].split(',').collect(&:to_i)

bingo_boards = []
input[2..-1].each_slice(6) { |slice| bingo_boards << BingoBoard.new(slice[0..4]) }
first_winner_found = false

numbers_drawn.each do |number_drawn|
  bingo_boards.each do |board|
    board.mark_number(number_drawn)
    if board.won?
      if !first_winner_found
        puts "First winner with - #{number_drawn} [#{board.sum_unmarked * number_drawn}]"
        board.debug
        first_winner_found = true
      elsif bingo_boards.all?(&:won?)
        puts "Last winner with - #{number_drawn} [#{board.sum_unmarked * number_drawn}]"
        board.debug
        exit
      end
    end
  end
end
