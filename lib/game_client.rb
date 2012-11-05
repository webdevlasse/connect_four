require 'socket'

connection = TCPSocket.open('localhost', 5600)
sleep 1
connection.write("@deepteal hello there")

connection.close

