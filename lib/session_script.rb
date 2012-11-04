require_relative '../lib/twitter_game'
require_relative '../lib/ai'

ai = AI.new
p2 = AI.new
game = TwitterGame.new("hi", "guy")
enemy_last = false
enemy_first = true

if enemy_first
  # game.board.show
  # puts game.current_player

  # Get challenger board
  # print "Pitiful human, make your move >> "
  # move = gets.chomp
  game.set_challenger_board(move)
  ai.play(game.challenger_move)
  p2.move
  game.next_turn
end

begin
  # game.board.show
  # puts game.current_player
  # AI MOVE
  move = ai.move
  game.send_move_to_board(move)
  p2.play(move)
  enemy_last = false
  # game.next_turn

  unless game.over?
    # Send board to twitter
    # game.board.show

    # Get challenger board
    # print "Pitiful human, make your move >> "
    # move = gets.chomp

    # Update challenger board
    game.set_challenger_board(move)

    # Update AI's board
    ai.play(game.challenger_move)
    p2.move
    game.next_turn
    enemy_last = true
  end

end until game.over?