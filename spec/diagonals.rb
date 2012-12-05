class Board  

  attr_reader :cells, :current_column_played, :num_rows, :num_cols
  def initialize(num_cols=7, num_rows=6)
    @cells = create_columns(num_cols)
    @num_rows = 6
    @num_cols = 7
    @current_column_played = 3
  end

  def create_columns(num_cols)
    (0..num_cols-1).reduce([]) { |cells| cells << Array.new }
  end

  def populate
    cells.each_with_index { |cell, index| 6.times { cell << index} }
  end

  def diagonals
    [first_diagonal, second_diagonal]
  end

  def first_diagonal
    build_diagonal(last_piece_coordinate, nearest_edge_coordinate(last_piece_coordinate), cells)
  end

  def second_diagonal
    piece_xy = [num_cols - last_piece_coordinate[0], last_piece_coordinate[1]]
    build_diagonal(piece_xy, nearest_edge_coordinate(piece_xy), transposed_board)
  end

  def build_diagonal(piece_coordinate, edge_coordinate, board)
    x, y = edge_coordinate
    diagonal_length = [num_cols - edge_coordinate[0], num_rows - edge_coordinate[1]].min
    (0..diagonal_length).map { |i| board[x + i][y + i] }
  end

  def nearest_edge_coordinate(piece_coordinate)
    piece_coordinate.map { |el| el - piece_coordinate.min }
  end
  
  def last_piece_coordinate
    [current_column_played, cells[current_column_played].length - 1]
  end

  def transposed_board
    new_board = []
    cells.each { |cell| new_board.unshift(cell) }
    new_board
  end

end