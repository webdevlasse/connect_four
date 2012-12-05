require_relative 'column'

class Board

  attr_reader :cells, :num_cols, :num_rows, :current_column_played, :current_player

  def initialize(num_cols = 7, num_rows = 6)
    @cells = create_columns(num_cols)
    @num_rows = num_rows
    @num_cols = num_cols
    @value
  end

  def to_twitter
    new_cells = create_columns(num_cols)
    cells.each_with_index do |column, index|
      column.each { |cell| new_cells[index] << cell }
    end

    new_cells.each do |column|
      if column.length < 6
        (6 - column.length).times { column.unshift(".") }
      end
    end.transpose
  end

  def set_cells(array)
    cells.replace(array)
    convert_to_columns
  end

  def convert_to_columns
    cells.map! do |array|
      column = Column.new
      array.each do |cell|
        column << cell
      end
      column
    end
  end

  def column_length(column_index)
    cells[column_index].nil? ? 0 : cells[column_index].length
  end

  def place(column_index, player)
    @current_column_played = column_index
    @current_player = player
    cells[column_index].place(player, num_rows)
  end

  def create_columns(num_cols)
    (0..num_cols-1).reduce([]) { |cells| cells << Column.new }
  end

  def populate
    cells.each_with_index { |cell, index| 6.times { cell << index} }
  end

  def set_last(col_num)
    @current_column_played = col_num
  end

  def state
    if column_win? || row_win? || diagonal_win?
      return :win
    elsif tie?
      return :tie
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
    row_pieces = nil_to_hash_sign(cells.map { |column| column[last_piece_row_index] }).join
    connect_four?(row_pieces)
  end

  def diagonal_win?
    first_pieces, second_pieces = diagonals.map { |diagonal| nil_to_hash_sign(diagonal).join }
    connect_four?(first_pieces) || connect_four?(second_pieces)
  end

  def connect_four?(pieces)
    !(/1111|0000/.match(pieces)).nil?
  end

  def nil_to_hash_sign(array)
    array.map { |element| element.nil? ? "#" : element }
  end

  def nil_to_period(array)
    array.map { |element| element.nil? ? "." : element }
  end

  def diagonals
    d0 = left_top + [current_player] + right_bottom
    d1 = left_bottom + [current_player] + right_top
    [d0, d1]
  end

  def right_bottom
    right_array, column_index, row_index, num_cols = diagonal_elements

    until column_index == num_cols || row_index == 0
      column_index += 1
      row_index -= 1
      right_array << cells[column_index][row_index]
    end
    right_array
  end

  def left_top
    left_array, column_index, row_index = diagonal_elements

    until column_index == 0 || row_index == num_rows - 1
      column_index -= 1
      row_index += 1
      left_array << cells[column_index][row_index]
    end
    left_array.reverse
  end

    def right_top
    right_array, column_index, row_index, num_cols = diagonal_elements

    until column_index == num_cols || row_index == num_rows - 1
      column_index += 1
      row_index += 1
      right_array << cells[column_index][row_index]
    end
    right_array
  end

  def left_bottom
    left_array, column_index, row_index = diagonal_elements

    until column_index == 0 || row_index == 0
      column_index -= 1
      row_index -= 1
      left_array << cells[column_index][row_index]
    end
    left_array.reverse
  end

  def show
    index = num_rows - 1
    puts ""
    num_rows.times do
      cells.each { |column| column[index] != nil ? (print "| #{column[index]} ") : (print "|   ") }
      index -= 1
      print "|\n"
    end
    puts "============================="
    puts "| 1 | 2 | 3 | 4 | 5 | 6 | 7 |"
  end

  private

  def diagonal_elements
    [[], current_column_played, cells[current_column_played].length - 1, cells.length - 1]
  end

end
