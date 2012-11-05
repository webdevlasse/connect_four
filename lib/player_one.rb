require_relative '../lib/twitter_game'
require_relative '../lib/ai'
require 'socket'

# def listen(port)
#   server = TCPServer.open(port)
#   client = server.accept
#   board = client.read
#   client.close
#   board
# end

# def send(hostname, port, board)
#   client = TCPSocket.open(hostname, port)
#   client.send("hey", 0)
# end

ai = AI.new
p2 = AI.new
game = TwitterGame.new("hi", "guy")
enemy_last = false
enemy_first = false

begin 
  # AI MOVE
  move = ai.move
  game.send_move_to_board(move)
  p2.play(move)
  game.next_turn
  game.draw_board

  new_board = game.to_twitter
  client = TCPSocket.open('localhost', 5500)
  client.write(new_board)
  puts "Sending board: #{new_board}"
  client.close
  
  
  
  
  

  

  puts "Waiting for board..."
  server = TCPServer.open(6500)

  client = server.accept
  puts "Connection open..."

  move = client.read
  puts "Got board: #{move}"
  client.close
  server.close

  game.set_challenger_board(move)
  ai.play(game.challenger_move)
  p2.move
  game.next_turn

  game.draw_board
end until game.status == :win || game.status == :tie
