def HumanPlayer
  def move(board)
    puts board
    puts "what's your next move?"
    gets.chomp.to_i
  end
end