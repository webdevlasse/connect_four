require 'sqlite3'
require 'twitter'
require 'tweetstream'
require 'yaml'
require_relative '../lib/session'


# ----------------------------------------------------------------------------------------
# Twitter configuration
# ----------------------------------------------------------------------------------------

TWITTER_CONSUMER_KEY = "WRmFphJHaVLTdsKzkTg"
TWITTER_CONSUMER_SECRET = "FKEFaqBEDE5CnNnFaxkYyD18RCiWrMekruLJYykEaa0"
TWITTER_OAUTH_TOKEN = "921355608-f6VYIYZzqEJVRZxJ9ZaCT0boA47Q95O35TdCegzC"
TWITTER_OAUTH_TOKEN_SECRET = "Eb6DyOlDvG7KcMzthExkIaxoTObOmZ00BOOCU8VLvX4"

TweetStream.configure do |config|
    config.consumer_key       = TWITTER_CONSUMER_KEY
    config.consumer_secret    = TWITTER_CONSUMER_SECRET
    config.oauth_token        = TWITTER_OAUTH_TOKEN
    config.oauth_token_secret = TWITTER_OAUTH_TOKEN_SECRET
    config.auth_method        = :oauth
end

# ----------------------------------------------------------------------------------------
# Methods used for Twitter game flow: these need to be defined before running TweetStream
# ----------------------------------------------------------------------------------------

$sessions_container = []

def post_challenge
  post_id = Time.now.strftime("%F %T.%L")
  Twitter.update("Who wants to get demolished? \#dbc_c4 #{post_id}")
end

def acceptance?(message)
  return !(message =~ /[\s]*\@deepteal[\s]*[G|g]ame[\s]*on[!]?[\s]*\#dbc_c4/).nil?
end

def board?(message)
  return !(message =~ /[\s]*\@deepteal[\s]*(\|\S{7}\|\S{7}\|\S{7}\|\S{7}\|\S{7}\|\S{7}\|)[\s]*\#dbc_c4/).nil?
end

def take_challenge?(message)
  return !(message =~ /[W|w]ho wants to get demolished\? \#dbc_c4/).nil?
end

def not_already_playing?(opponent)
  $sessions_container.each do |session|
    return false if session.player == opponent
  end
  return true
end

def start_game(opponent, posted_accepted)
  $sessions_container << Session.new(opponent, posted_accepted)
end

def strip_to_board(message)
  message.match(/[\s]*\@deepteal[\s]*(\|\S{7}\|\S{7}\|\S{7}\|\S{7}\|\S{7}\|\S{7}\|)[\s]*\#dbc_c4/)
  return $1
end

def send_to_session(opponent, board)
  $sessions_container.each do |session|
    if session.player == opponent
      kill_session(session) if session.receive(board)
      return true
    end
  end
  false
end

def kill_session(session_to_kill)
  $sessions_container.delete_if { |session| session == session_to_kill }
end

# ----------------------------------------------------------------------------------------
# Post a challenge and open the TweetStream
# ----------------------------------------------------------------------------------------

post_challenge

##### Do first search outside of loop?
# first_search = Twitter.search("#dbc_c4", :count => 10, :result_type => "recent").results
# @tweets_container = first_search

# if $sessions_container.length < 6
#       p @tweets_container
#       @tweets_container.each do |status|
#         puts 'second'
#         msg = status.text
#         opponent = status.user.screen_name
#         if not_already_playing?(opponent) && acceptance?(msg)
#           puts 'accept'
#           Twitter.update("\@#{opponent} get ready to be crushed!")
#           start_game(opponent, 'posted')
#           post_challenge
#         elsif board?(msg)
#           puts 'received'
#           board = strip_to_board(msg)
#           send_to_session(opponent, board)
#         elsif not_already_playing?(opponent) && take_challenge?(msg)
#           puts 'take'
#           Twitter.update("\@#{opponent} Game on! \#dbc_c4")
#           start_game(opponent, 'accepted')
#         end
#       end
#     end

loop do
  @last_status_id = 0 || @tweets_container.last.status_id
  @tweets_container = []
  # array = Twitter.search("#dbc_c4", :count => 10, :result_type => "recent", :since_id => @last_status_id).results
  # @tweets_container = []
  @tweets_container = Twitter.search("#dbc_c4", :count => 10, :result_type => "recent", :since_id => @last_status_id).results
  # @tweets_container = []

# TweetStream::Client.new.track('#dbc_c4') do |status|
# .on_delete{ |status_id, user_id| puts "2"
#   Tweet.delete(status_id)
#   puts "3"
#   }.on_limit { |skip_count|
#     puts "skipping"
#     sleep 5
  # }
  # status.each do |obj|
  #   $tweets_container.unshift(status.pop)
  #   $tweets_container.push(obj) if !$tweets_container.include?(obj)
  # end

  # ($tweets_container.length - 10).times do
  #   $tweets_container.delete_at(10)
  # end

    # array.each do |tweet|
    #   p tweet.created_at
    #   p $time
    #   if tweet.created_at >= $time
    #     @tweets_container.unshift(tweet)
    #   end
    # end

    puts "first"
    p $sessions_container
      # p @tweets_container
      @tweets_container.each do |status|
        puts 'second'
        msg = status.text
        opponent = status.user.screen_name
        if $sessions_container.length < 2 && not_already_playing?(opponent) && acceptance?(msg)
          puts 'accept'
          Twitter.update("\@#{opponent} get ready to be crushed! #{Time.now}")
          start_game(opponent, 'posted')
          # post_challenge
        elsif board?(msg)
          puts 'received'
          board = strip_to_board(msg)
          send_to_session(opponent, board)
        # elsif $sessions_container.length < 2 && not_already_playing?(opponent) && take_challenge?(msg)
        #   puts 'take'
        #   Twitter.update("\@#{opponent} Game on! \#dbc_c4 #{Time.now}")
        #   start_game(opponent, 'accepted')
        end
      end
  sleep 10
end

