class TwitterPlayer
  attr_accessor :symbol

  def initialize(symbol)
    self.symbol = symbol
  end

  def move(board)
    # look over board
    # board.place(move)
    begin
      board.place(move, symbol)
    rescue InvalidMoveException => ex
      puts "Woops! #{ex.message}"
      retry
    end
    # post move to twitter
  end
end