require_relative 'twitter_game'
require_relative 'game_router_client'

def strip_username(message)
  /(\|\S{7}\|\S{7}\|\S{7}\|\S{7}\|\S{7}\|\S{7}\|)/.match(message)
  $1
end

P1_USERNAME = "playerone"

grclient = GameRouterClient.new('192.168.0.150', 5600, 'playertwo')
game = TwitterGame.new("new", "game")

# Register with GameRouter
grclient.register

begin
  # Wait for board
  new_board = listen
  # Set challenger move
  game.set_challenger_board(new_board)
  game.challenger_move
  game.next_turn

  # Wait for user move
  game.draw_board
  print "Choose a column to play >> "
  until game.send_move_to_board(move)
    puts "Either that column is full or that column doesn't exist. Please choose another column."
    move = gets.chomp.to_i
  end
  message = "@#{P1_USERNAME} #{game.to_twitter}"
  
  # Send move to GameRouter
  grclient.send(message)
  game.next_turn
end until game.status == :win || game.status == :tie
