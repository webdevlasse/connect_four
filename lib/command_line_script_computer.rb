require_relative 'game.rb'
require_relative 'user.rb'
require_relative 'computer.rb'

puts 'player0 is the computer'
computer = Computer.new
puts 'player1, enter your twitter name'
human = User.new(gets.chomp, 1)

game = Game.new

player_input = computer.move
game.send_move_to_board(player_input)
game.board.show

until game.status == :win || game.status == :tie
  game.next_turn

  puts "Player #{game.current_player}, please enter move"
  player_input = gets.chomp.to_i
  until game.send_move_to_board(player_input)
    puts "Either that column is full or that column doesn't exist. Please choose another column."
    player_input = gets.chomp.to_i
  end
  game.board.show

  if game.status == nil
    game.next_turn

    player_input = computer.move
    game.send_move_to_board(player_input)
    game.board.show
  end
end


human.update_stats(game.result)
puts "Player #{game.current_player} won!"
p human.show_stats

