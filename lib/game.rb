class Game
  attr_reader :board, :current_player
  def initialize
    @board = []
    @current_player = 0
  end

  def game_status
    @board.state
    #=> win, tie or nil (keep playing)
    # won? || tie? ? true : false
  end

  def next_turn
    if current_player == 0
      @current_player = 1
    else
      @current_player = 0
    end
  end

  def send_move_to_board(field)
    raise ArgumentError if field.nil?
    @board.place_piece(field)
  end

  def save_game_result
    game_result
  end

  def game_result
    result = { @current_player => '', other_player => '' }
    if won?
      result[@current_player] = :won
      result[@other_player] = :lost
    elsif tie?
      result[@current_player] = :tied
      result[@other_player] = :tied
    else
      result[@current_player] = :lost
      result[@other_player] = :won
    end
    result
  end

  private
  def other_player
    current_player == 0 ? 1 : 0
  end


  # def won?
  #   @board.won?
  # end
  #
  # def tie?
  #   @board.tie?
  # end
end