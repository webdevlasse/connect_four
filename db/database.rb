class Database
  def initialize
    @db = SQLite3::Database.new( 'test.db' ) do |db|
      db.execute("CREATE TABLE IF NOT EXISTS Players (Id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT(5))

           CREATE TABLE IF NOT EXISTS Games (Id INTEGER PRIMARY KEY AUTOINCREMENT,
                                           Result TEXT(10), Player_id TEXT(5)))"
  end
end