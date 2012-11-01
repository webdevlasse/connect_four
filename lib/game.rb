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

  def save_game_result
    game_result
    #saves outcome of game to DB
  end

  def game_result
    result = { @current_player => '', other_player => '' }
    if won?
      result[@current_player], result[@other_player] = :win, :loss
    elsif tie?
      result[@current_player], result[@other_player] = :tie, :tie
    end
    result
  end

  # def play_human_vs_human
  #   puts "Player #{current_player}, please enter move"
  #   player_input = gets.chomp.to_i
  #   send_move_to_board(player_input)
  #
  #   until status == :win || status == :tie
  #     next_turn
  #     puts "Player #{current_player}, please enter move"
  #     player_input = gets.chomp.to_i
  #     until send_move_to_board(player_input)
  #       puts "That column is full. Please choose another column."
  #       player_input = gets.chomp.to_i
  #     end
  #   end
  #   p board
  #   puts "Player #{current_player} won!"
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