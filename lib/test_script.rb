require_relative 'game.rb'

game = Game.new
# game.play_human_vs_human
puts "If you would like to play against the computer, please enter 'computer' now. If you would like to compete against someone real, please enter 'person' now..."
game.board.show
puts "Player #{game.current_player}, please enter move"
player_input = gets.chomp.to_i
until player_input <= 7 && player_input > 0
  puts "That column doesn't exist. Please choose another column."
  player_input = gets.chomp.to_i
end
game.send_move_to_board(player_input)
game.board.show

until game.status == :win || game.status == :tie
  game.next_turn
  puts "Player #{game.current_player}, please enter move"
  player_input = gets.chomp.to_i
  until player_input <= 7 && player_input > 0 && game.send_move_to_board(player_input)
    puts "Either that column is full or that column doesn't exist. Please choose another column."
    player_input = gets.chomp.to_i
  end
  game.board.show
end

puts "Player #{game.current_player} won!"

