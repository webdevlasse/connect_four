require_relative 'connect_four_board'
require_relative 'game_node'

class ConnectFourNode < GameNode

  attr_reader :player, :board

  def initialize(player, board)
    @player = player
    @board = board
  end


  def get_moves
    value = leaf_value
    return {} unless value.nil?

    moves = {}
    7.times do |index|
      if board.cells[index].available?
        new_board = ConnectFourBoard.new
        new_board.set_cells(board)
        new_board.place(index, 1 - player)
        moves["#{index}"] = self.class.new(1 - player, new_board)
      end
    end
    moves
  end

  def leaf_value
     
  end

  def eql?(other)
    if board == other.board
      raise unless player == other.player
      return true
    end
    false
  end

  def hash
    board.hash
  end

end