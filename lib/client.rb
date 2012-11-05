require 'socket'      # Sockets are in standard library

hostname = 'localhost'
port = 5500

s = TCPSocket.open(hostname, port)
s.write("board")