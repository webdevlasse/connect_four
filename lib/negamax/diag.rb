require_relative 'column'

class Board

  attr_reader :cells, :num_rows, :current_column_played, :current_player

  def initialize(num_cols = 7, num_rows = 6)
    @cells = create_columns(num_cols)
    @num_rows = num_rows
  end

  def place(column_index, player)
    @current_column_played = column_index
    @current_player = player
    cells[column_index].place(player, num_rows)
  end

  def create_columns(num_cols)
    (0..num_cols-1).reduce([]) { |cells| cells << Column.new }
  end

  def state
    if column_win? || row_win? || diagonal_win?
      return WIN
    elsif tie?
      return TIE
    end
    nil
  end

  def tie?
    cells.inject(0) { |total_cells, column| total_cells += column.length } == num_rows * cells.length
  end

  def column_win?
    column_pieces = cells[current_column_played].join
    connect_four?(column_pieces)
  end

  def row_win?
    last_piece_row_index = @cells[current_column_played].length - 1
    row_pieces = cells.map { |column| column[last_piece_row_index] }.join
    connect_four?(row_pieces)
  end

  def diagonal_win?
    d0_pieces, d1_pieces = diagonals.map { |diagonal| nil_to_hash_sign(diagonal).join }
    connect_four?(d0_pieces) || connect_four?(d1_pieces)
  end

  def connect_four?(pieces)
    !(/1111|0000/.match(pieces)).nil?
  end

  def nil_to_hash_sign(array)
    array.map { |element| element.nil? ? "#" : element }
  end

  def diagonals
    [first_diagonal, second_diagonal]
  end

  def first_diagonal

  end

  def second_diagonal
  end

  def nearest_edge
    last_piece_coordinate.map { |el| el - last_piece_coordinate.min }
  end
  def last_piece_coordinate
    [current_column_played, cells[current_column_played].length - 1]
  end


end

