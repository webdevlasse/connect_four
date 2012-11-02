require_relative 'col'
require_relative 'board'


class ConnectFourBoard < Board

  attr_reader :cells, :num_cols, :num_rows, :current_column_played, :current_player, :value

  def initialize
    @num_cols = 7
    @num_rows = 6
    @cells = self.create_columns(num_cols)
  end

  def set_cells(cells)
    cells.replace = cells
  end

  def place(column_index, player)
    @current_column_played = column_index
    @current_player = player
    cells[column_index].place(player)
  end

  def create_columns(num_cols)
    (0..num_cols-1).reduce([]) { |cells| cells << Col.new(num_rows, "b") }
  end




  def self.from_line(line)
    converted_cells = line.split(',')
    converted_cells.pop

    board = ConnectFourBoard.new

    converted_cells.map! do |cell|
      case cell
      when 'b' then 'b'
      when 'x' then 0
      when 'o' then 1
      end
    end
    
    board.cells.each do |column|
      board.num_rows.times { column.pop }
      board.num_rows.times { column << converted_cells.shift }
    end
    board
  end    

end
