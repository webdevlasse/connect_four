require 'sqlite3'

class User
  attr_reader :twitter_username, :wins, :ties, :losses, :player_number
  def initialize(twitter_username='@whatever', player_number = 0)
    @twitter_username = twitter_username
    @player_number = player_number
    set_stats
  end

  def update_stats(game_result)
    if game_result[player_number] == :win
      @wins += 1
    elsif game_result[player_number] == :tie
      @ties += 1
    else
      @losses += 1
    end
    save_game_result
  end

  def show_stats
    user_record(open_db)
  end

  private

  def set_stats
    db = open_db
    if user_record(db) != nil
      @wins = db.execute("SELECT wins FROM Players WHERE twitter_username = (?)", twitter_username).first.first
      @ties = db.execute("SELECT ties FROM Players WHERE twitter_username = (?)", twitter_username).first.first
      @losses = db.execute("SELECT losses FROM Players WHERE twitter_username = (?)",     twitter_username).first.first
    else
      @wins, @ties, @losses = 0, 0, 0
      db.execute("INSERT INTO Players(twitter_username, wins, ties, losses) VALUES(?,0,0,0)", twitter_username)
    end
  end

  def save_game_result
    open_db.execute("UPDATE Players SET wins = (?), ties = (?), losses = (?) WHERE twitter_username = (?)", wins, ties, losses, twitter_username)
  end

  def open_db
    SQLite3::Database.new( "../db/connect_four.db" )
  end

  def user_record(db)
    db.execute("SELECT * FROM Players WHERE twitter_username = (?)", twitter_username)[0]
  end
end

# user = User.new(@something)
# user.stats
# => user.twitter_username

# user = User.new('something')
# p user.set_stats
# user2 = User.new
# p user2.set_stats
# user2.save_game_result
# p user2.show_stats
