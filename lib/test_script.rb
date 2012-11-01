game = Game.new

until game.game_status == :won || :tie
  game.send_move_to_board(player_input)
  game.next_turn
end
game.save_game_result

