require 'socket'

class MessageRouterClient

  attr_reader :server, :port, :username, :listen_port

  def initialize(server_hostname, server_port, user_name)
    @server = server_hostname
    @port = server_port
    @username = user_name
    @listen_port = Random.rand(2000..30_000)
  end

  def register
    send("@register #{username} #{listen_port}")
  end

  def send(message)
    socket = TCPSocket.open(server, port)
    sleep 1
    socket.write(message)
    socket.close
    #puts "Waiting for server acknowledgement..."
    #listen
  end

  def new_listen_port
    @listen_port = Random.rand(1000..30_000)
  end

  def listen
    puts "Listening on #{listen_port}..."
    server = TCPServer.open(listen_port)
    client = server.accept
    puts "Connection open, waiting for message..."
    message = client.read
    client.close
    server.close
    message
  end
  
end
