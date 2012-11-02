require_relative 'game'
require_relative 'ai'

ai = AI.new
p2 = AI.new
game = Game.new
human_last = false

begin
  print "Would you like to be player 1 or 2? >>"
  human_player = gets.chomp.to_i
end while human_player < 1 || human_player > 2

# AI goes first if human is player 2
if human_player == 2
  move = ai.move
  game.send_move_to_board(move)
  p2.play(move)
  game.next_turn
end

begin
  game.board.show
  print "Pitiful human, make your move >>"
  move = gets.chomp.to_i
  until game.send_move_to_board(move)
    puts "Either that column is full or that column doesn't exist. Please choose another column."
    move = gets.chomp.to_i
  end
  ai.play(move)
  p2.move
  human_last = true
  game.board.show
  
  unless game.over?
    game.next_turn
    puts "====curplayer==="
    puts game.current_player
    move = ai.move
    game.send_move_to_board(move)
    p2.play(move)
    human_last = false
  end

end until game.over?
game.next_turn # one more time to set conditionals
game.board.show

if human_player == 2 || (game.status == :win && !human_last)
  puts "LOL, why did you even try?"
elsif game.status == :tie
  puts "Good job, at least you have half a brain."
elsif game.status == :win && human_last
  puts "Ok player 1, you are either Joe or pretty smart"
end