require_relative 'board.rb'

class Game
  attr_reader :board, :current_player
  def initialize
    @board = Board.new
    @current_player = 0
  end

  def status
    @board.state
  end

  def next_turn
    if current_player == 0
      @current_player = 1
    else
      @current_player = 0
    end
  end

  def send_move_to_board(column)
    column.between?(1,7) ? @board.place(column - 1, current_player) : false
  end

  def result
    result = [:loss, :loss]
    if won?
      result[current_player] = :win
    elsif tie?
      result = [:tie, :tie]
    end
    result
  end

  private
  def other_player
    current_player == 0 ? 1 : 0
  end

  def won?
    status == :win
  end

  def tie?
    status == :tie
  end
end