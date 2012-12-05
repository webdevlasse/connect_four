require_relative 'twitter_game'
require_relative 'message_router_client'

def strip_username(message)
  /(\|\S{7}\|\S{7}\|\S{7}\|\S{7}\|\S{7}\|\S{7}\|)/.match(message)
  $1
end

print "Player 1, please enter your username >> "
p1_username = gets.chomp
print "Please enter Player 2's username >> "
p2_username = gets.chomp

grclient = MessageRouterClient.new('192.168.0.150', 5600, p1_username)
game = TwitterGame.new("new", "game")

# Register with GameRouter
grclient.register

begin
  # Wait for user move
  game.draw_board
  print "Choose a column to play >> "
  move = gets.chomp.to_i
  until game.send_move_to_board(move)
    puts "Either that column is full or that column doesn't exist. Please choose another column."
    move = gets.chomp.to_i
  end
  message = "@#{p2_username} #{game.to_twitter}"
  
  # Send move to GameRouter
  grclient.send(message)
  game.next_turn

  # Wait for board
  new_board = grclient.listen
  # Set challenger move
  game.set_challenger_board(new_board)
  game.challenger_move
  game.next_turn

end until game.status == :win || game.status == :tie