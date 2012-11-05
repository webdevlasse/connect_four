require 'socket'
require_relative 'game_server_user'


class GameRouter

  attr_reader :port, :registered_users, :open_ports

  def initialize(listening_port)
    @port = listening_port
    @registered_users = {}
    @open_ports = []
  end

  def start
    server = TCPServer.open(port)
    begin

      puts "Listening on port: #{port}..."
      Thread.start(server.accept) do |client|
        fam, port, ip, hostname = client.addr
        puts "Connection initiated from #{hostname}:#{port}"
        message = client.read
        puts "Message from #{hostname}:#{port}: #{message}"
        puts handle(message, port, ip)
        puts "Closing connection from #{hostname}:#{port}"
        client.close
      end

    end while true
  end

  def handle(message, port, ip)
    if register?(message)
      puts "first"
      register(strip_username_port(message), ip)
    elsif has_recipient?(message)
      forward_message(strip_recipient(message), message)
    else
      "Message not handled"
    end
  end

  def register?(message)
    return true if /@register/.match(message)
    false
  end

  def strip_username_port(message)
    /@register\s+(.+)\s+(\d+)/.match(message)
    [$1, $2]
  end

  def register(username_port_array, ip)
    username, port = username_port_array
    username = "@#{username}"
    registered_users[username] = GameServerUser.new(port.to_i, ip)
    if registered?(username)
      "Successfully registered #{username}"
    else
      "Failed to register #{username}"
    end
  end

  def registered?(username)
    registered_users.has_key?(username)
  end

  def has_recipient?(message)
    return true if /(@.+)\s+/.match(message)
    false
  end

  def strip_recipient(message)
    message.split[0]
  end

  def forward_message(recipient, message)
    if registered?(recipient)
      info = registered_users[recipient]
      puts "Sending message to #{recipient}, host: #{info.hostname} port: #{info.port}"
      socket = TCPSocket.open(info.hostname, info.port)
      sleep 1
      socket.write(message)
      socket.close
      return "Sent #{message} to #{recipient}"
    end
    "Failed delivery to #{recipient}"
  end

  def port_open?(port)
    open_ports.include?(port)
  end

end

router = GameRouter.new(5600)
router.start