require_relative '../lib/twitter_game'
require_relative '../lib/ai'
require 'socket'

def listen(port)
  server = TCPServer.open(port)
  client = server.accept
  board = client.read
  client.close
  board
end

def send(hostname, port, board)
  client = TCPSocket.open(hostname, port)
  s.write(board)
end

ai = AI.new
p2 = AI.new
game = TwitterGame.new("hi", "guy")
enemy_last = false
enemy_first = false

if enemy_first
  game.board.show

  # Get challenger board
  print "Pitiful human, make your move >> "
  move = gets.chomp
  game.set_challenger_board(move)
  ai.play(game.challenger_move)
  p2.move
  game.next_turn
end

begin
  game.board.show
  # AI MOVE
  move = ai.move
  game.send_move_to_board(move)
  send(game.board.to_twitter)
  p2.play(move)
  enemy_last = false
  game.next_turn

  unless game.over?
    #wait for twitter board
    move = listen(5600)
    # Update challenger board
    game.set_challenger_board(move)

    # Update AI's board
    ai.play(game.challenger_move)
    p2.move
    game.next_turn
    enemy_last = true
  end

end until game.over?