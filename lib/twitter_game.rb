require_relative 'game'

class TwitterGame < Game

  attr_reader :twitter_username, :challenger, :challenger_board

  def initialize(twitter_username, challenger_username)
    super()
    @twitter_username = twitter_username
    @challenger = challenger_username
    @challenger_board = Board.new
  end

  def to_twitter
    twitter_rows = board.to_twitter
    twitter_board = "|"
    twitter_rows.each { |row| twitter_board << "#{row.join}|"}
    convert_pieces!(twitter_board, /0/, "X")
    convert_pieces!(twitter_board, /1/, "O")
    twitter_board
  end

  def set_challenger_board(string) 
    convert_pieces!(string, /X/, "0")
    convert_pieces!(string, /O/, "1")
    rows = string.split("|")
    rows.shift
    rows = rows.map { |row| row.split("") }.reverse.transpose
    # IS THIS CORRECTLY TRANSLATING THE POSITIONS OF THE PIECES?
    rows.map! { |row| row.join }
    rows.map! { |row| row.split(".") }
    rows.map! { |row| row.join.split("") }
    rows.map! { |row| row.map { |col| col.to_i } }
    challenger_board.set_cells(rows)
  end

  def challenger_move
    column_index = 0
    # puts challenger_board.cells.inspect
    board.cells.each_with_index do |col, index|
      column_index = index if challenger_board.column_length(index) > board.column_length(index)
    end
    board.place(column_index, 1)
    column_index + 1
  end

  private

  def convert_pieces!(string, pattern, sub)
    string.gsub!(pattern, sub)
  end

end
