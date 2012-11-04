require_relative '../lib/twitter_game'
require_relative '../lib/ai'

ai = AI.new
p2 = AI.new
game = TwitterGame.new("hi", "guy")
human_last = false

begin
  print "Would you like to be player 1 or 2? >> "
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
  print "Pitiful human, make your move >> "
  move = gets.chomp

  # NEED TO SET CURRENT_COLUMN_PLAYED SOMEWHERE IN HERE!!!
  puts "HEHEHEH"
  game.set_challenger_board(move)
  # puts game.board.inspect
  # puts game.challenger_board.inspect
  #update ai's board
  ai.play(game.challenger_move)
  p2.move
  game.next_turn
  human_last = true
  game.board.show

  p game.board.current_column_played
  p game.board.row_win?
  p game.board.column_win?
  p game.board.diagonal_win?
  p game.board.state
  p game.over?
  
  unless game.over?
    move = ai.move
    game.send_move_to_board(move)
    p2.play(move)
    human_last = false
    game.next_turn
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