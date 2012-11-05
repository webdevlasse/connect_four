require_relative '../lib/twitter_game'
require_relative '../lib/ai'
require 'socket'


ai = AI.new
p2 = AI.new
game = TwitterGame.new("hi", "guy")


begin 
  # Get challenger board
  puts "Waiting for board..."
  server = TCPServer.open(5500)

  client = server.accept
  puts "Connection open..."

  new_board = client.read
  puts "Got board: #{new_board}"
  client.close
  server.close

  game.set_challenger_board(new_board)
  ai.play(game.challenger_move)
  p2.move
  game.next_turn
  game.draw_board


  move = ai.move
  game.send_move_to_board(move)
  puts "Opening connection..."
  connection = TCPSocket.open('localhost', 6500)

  new_board = game.to_twitter
  puts "Connection open, sending board: #{new_board}"
  connection.write(new_board)
  connection.close
  p2.play(move)
  game.next_turn

  game.draw_board
end until game.status == :win || game.status == :tie