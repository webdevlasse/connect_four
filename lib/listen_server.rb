require 'socket'

server = TCPServer.open(16757)
begin
  puts "Listening..."
  
  client = server.accept
  fam, port, ip, hostname = client.addr
  puts "Connection initiated from #{hostname}:#{port}"
  message = client.read
  puts "Message from #{hostname}:#{port}: #{message}"
  puts "Closing connection from #{hostname}:#{port}"
  client.close

end unless message == '@deepteal quit'
    
  