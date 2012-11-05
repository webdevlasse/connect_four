require 'sqlite3'
require 'twitter'
require 'tweetstream'
require 'yaml'
require_relative '../lib/twitter_game'
require_relative '../lib/ai'

class Session
  attr_reader :player, :game, :p2, :ai

  def initialize(opponent, posted_accepted)
    @player = opponent
    if posted_accepted == 'posted'
      @ai = AI.new
      @p2 = AI.new
      # is the player attr reader set to the opponent's Twitter username?
      @game = TwitterGame.new('deepteal2', opponent)
      move = ai.move
      game.send_move_to_board(move)
      p2.play(move)
      send_board_back(game.to_twitter)
    else
      @ai = AI.new
      @p2 = AI.new
      @game = TwitterGame.new(opponent, 'deepteal2')
    end
  end

  def receive(board)
    game.set_challenger_board(board)
    move = ai.move
    game.send_move_to_board(move)
    p2.play(move)
    board_to_send = game.to_twitter
    # if game.over?
    #   send_win_message(board_to_send)
    #   # Save to DB
    #   return true
    # end
    send_board_back(board_to_send)
    return false
  end

  def send_win_message(board_to_send)
    post_id = Time.now.strftime("%F %T.%L")
    Twitter.update("\@#{player} #{board_to_send} I win! Good game. #dbc_c4 #{post_id}")
  end

  def send_board_back(board_to_send)
    post_id = Time.now.strftime("%F %T.%L")
    Twitter.update("\@#{player} #{board_to_send} #dbc_c4 #{post_id}")
  end
end

