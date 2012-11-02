require_relative 'connect_four_board'
require_relative 'game_node'

class ConnectFourNode < GameNode

  attr_reader :player, :board

  def initialize(player, board)
    @player = player
    @board = board
    @count = 0
    @max = 0
  end


  def get_moves
    return {} unless leaf_value.nil?

    moves = {}
    7.times do |index|
      if board.cells[index].available?
        new_board = ConnectFourBoard.new
        new_board.set_cells(board.cells)
        new_board.place(index, 1 - player)
        moves["#{index}"] = self.class.new(1 - player, new_board)
      end
    end
    moves
  end

  def leaf_value
     if @count > @max
      @count += 1
      return false
    end
  end

  def eql?(other)
    if board == other.board
      raise unless player == other.player
      return true
    end
    false
  end

  def hash
    board.cells.hash
  end

end