require 'socket'               # Get sockets from stdlib

server = TCPServer.open(5500)  # Socket to listen on port 2000

begin 
  puts 'Listening for connection...'
  client = server.accept
  puts 'Connection open, waiting for message'
  message = client.read
  puts "Received: #{message}"
  client.close
end while message != 'exit'

# require 'socket'                # Get sockets from stdlib
# @move = ""
# server = TCPServer.open(5500)   # Socket to listen on port 2000
# loop {        
#   puts "Waiting for connection..."                  # Servers run forever
#   Thread.start(server.accept) do |client|
#     puts "Connection open..."
#     @move = client.read
#     client.close   
#     puts "Connection closed..."        # Disconnect from the client
#   end
#   puts @move
# }