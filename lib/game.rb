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
    @board.place(column - 1, current_player)
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

  # def result
  #   result = [[@current_player, ''], [other_player, '']]
  #   if won?
  #     result[0][1] = :win
  #     result[1][1] = :loss
  #     #result[@current_player], result[@other_player] = :win, :loss
  #   elsif tie?
  #     result[0][1] = :tie
  #     result[1][1] = :tie
  #     # result[@current_player], result[@other_player] = :tie, :tie
  #   end
  #   result
  # end

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