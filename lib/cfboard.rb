require_relative 'column'
require_relative 'board'


class CFBoard < Board

  attr_reader :cells, :num_cols, :num_rows, :current_column_played, :current_player, :value

  def initialize(value)
    @num_cols = 7
    @num_rows = 6
    @value = value
    @cells = self.create_columns(num_cols)
  end

  def self.from_line(line)
    converted_cells = line.split(',')
    value = ""
    
    case converted_cells.pop
    when "win" then value = WIN
    when "draw" then value = DRAW
    when "loss" then value = LOSS
    end

    board = CFBoard.new(value)

    converted_cells.map! do |cell|
      case cell
      when 'b' then 'b'
      when 'x' then 0
      when 'o' then 1
      end
    end
    
    board.cells.each do |column|
      board.num_rows.times { column << converted_cells.shift }
    end
    board
  end

end
