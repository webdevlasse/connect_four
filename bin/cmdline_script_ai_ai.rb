require_relative '../lib/game'
require_relative  '../lib/ai'


game = Game.new

player_1 = AI.new
player_2 = AI.new

move = player_1.move
game.send_move_to_board(move)
player_2.play(move)

until game.status == :win || game.status == :tie
  game.next_turn
  move = player_2.move
  game.send_move_to_board(move)
  player_1.play(move)
  game.board.show

  game.next_turn
  move = player_1.move
  game.send_move_to_board(move)
  player_2.play(move)  
  game.board.show
end

puts "Player 1 wins..."