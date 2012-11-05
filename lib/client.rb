# require 'socket'      # Sockets are in standard library

# hostname = 'localhost'
# port = 5500

# s = TCPSocket.open(hostname, port)
# s.write("WHATSUP")

require_relative '../lib/twitter_game'
require_relative '../lib/ai'
require 'socket'
ai = AI.new
p2 = AI.new
game = TwitterGame.new("hi", "guy")


move = ai.move
game.send_move_to_board(move)
new_board = game.to_twitter
p2.play(move)
game.next_turn

client = TCPSocket.open('localhost', 5500)
client.write(new_board)
client.close

server = TCPServer.open(6500)
puts "Waiting for board..."

client = server.accept
# puts "Connection open..."

# board = connection.read
# puts "Got board: #{board}"