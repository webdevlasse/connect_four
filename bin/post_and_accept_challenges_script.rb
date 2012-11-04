require 'sqlite3'
require 'twitter'
require 'tweetstream'
require 'yaml'
require_relative '../lib/session'


# ----------------------------------------------------------------------------------------
# Twitter configuration
# ----------------------------------------------------------------------------------------

TWITTER_CONSUMER_KEY = "yR6hU0qcwt0vVd8GRwchXw"
TWITTER_CONSUMER_SECRET = "VQTgrwTonVYJQY4o1nS1ucAJ3eUILfOOhcUkKoLFko"
TWITTER_OAUTH_TOKEN = "921355608-LBZ9ASptzT0f9tAbCmcxJjREcjj82kMnMdzrrBbT"
TWITTER_OAUTH_TOKEN_SECRET = "jdsihj0ZNeTXZxaGEJ4h0yp6RUkj1SOMe8dGbaM20"

Twitter.configure do |config|
    config.consumer_key       = TWITTER_CONSUMER_KEY
    config.consumer_secret    = TWITTER_CONSUMER_SECRET
    config.oauth_token        = TWITTER_OAUTH_TOKEN
    config.oauth_token_secret = TWITTER_OAUTH_TOKEN_SECRET
end

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

def start_game(opponent)
  $sessions_container << Session.new(opponent)
end

def strip_to_board(message)
  message.match(/[\s]*\@deepteal[\s]*(\|\S{7}\|\S{7}\|\S{7}\|\S{7}\|\S{7}\|\S{7}\|)[\s]*\#dbc_c4/)
  return $1
end

def send_to_session(opponent, board)
  $sessions_container.each do |session|
    if session == opponent
      kill_session(session) if session.receive(board)
      return true
    end
  end
  false
end

def kill_session(session_to_kill)
  $session_container.delete_if { |session| session == session_to_kill }
end

# ----------------------------------------------------------------------------------------
# Post a challenge and open the TweetStream
# ----------------------------------------------------------------------------------------

# post_challenge

# Twitter.search("#dbc_c4").results.map do |status|
TweetStream::Client.new.track('#dbc_c4') do |status|
# .on_delete{ |status_id, user_id| puts "2"
#   Tweet.delete(status_id)
#   puts "3"
#   }.on_limit { |skip_count|
#     puts "skipping"
#     sleep 5
  # }
    puts 'Message:'
    puts "#{status.user.screen_name}"
    puts "#{status.text}"
    if $sessions_container.length < 6
      puts 'running'
      msg = status.text
      opponent = status.user.screen_name
      if not_already_playing?(opponent) && acceptance?(msg)
        puts 'accept'
        Twitter.update("\@#{opponent} get ready to be crushed!")
        start_game(opponent, 'posted')
        post_challenge
      elsif board?(msg)
        puts 'received'
        board = strip_to_board(msg)
        send_to_session(opponent, board)
      elsif not_already_playing?(opponent) && take_challenge?(msg)
        puts 'take'
        Twitter.update("\@#{opponent} Game on! \#dbc_c4")
        start_game(opponent, 'accepted')
      end
    end
  end


