require 'twitter'

Twitter.configure do |config|
  config.consumer_key = "yR6hU0qcwt0vVd8GRwchXw"
  config.consumer_secret = "VQTgrwTonVYJQY4o1nS1ucAJ3eUILfOOhcUkKoLFko"
end

@laila_r_w = Twitter::Client.new(
  :oauth_token => "921355608-LBZ9ASptzT0f9tAbCmcxJjREcjj82kMnMdzrrBbT",
  :oauth_token_secret => "jdsihj0ZNeTXZxaGEJ4h0yp6RUkj1SOMe8dGbaM20"
  )


# @client = Twitter::Client.new(
#   :consumer_key => "yR6hU0qcwt0vVd8GRwchXw",
#   :consumer_secret => "VQTgrwTonVYJQY4o1nS1ucAJ3eUILfOOhcUkKoLFko",
#   :oauth_token => "921355608-LBZ9ASptzT0f9tAbCmcxJjREcjj82kMnMdzrrBbT",
#   :oauth_token_secret => "jdsihj0ZNeTXZxaGEJ4h0yp6RUkj1SOMe8dGbaM20"
# )

# Twitter.update("testing twitter gem")
# @laila_r_w.update("testing twitter gem 2")

