require_relative '../lib/game.rb'
require_relative '../lib/user.rb'

puts 'player0, enter your twitter name'
user0 = User.new(gets.chomp, 0)
puts 'player1, enter your twitter name'
user1 = User.new(gets.chomp, 1)

game = Game.new

game.board.show
puts "Player #{game.current_player}, please enter move"
player_input = gets.chomp.to_i
until game.send_move_to_board(player_input)
  puts "That column doesn't exist. Please choose another column."
  player_input = gets.chomp.to_i
end

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
end

user0.update_stats(game.result)
user1.update_stats(game.result)
puts "Player #{game.current_player} won!"
p user0.show_stats
p user1.show_stats

