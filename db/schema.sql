-- db = CREATE TABLE IF NOT EXISTS Players (Id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT(5))
--
--      CREATE TABLE IF NOT EXISTS Games (Id INTEGER PRIMARY KEY AUTOINCREMENT,
--                                      Result TEXT(10), Player_id TEXT(5))

CREATE TABLE IF NOT EXISTS Players (Id INTEGER PRIMARY KEY AUTOINCREMENT, twitter_username VARCHAR(50)), wins INTEGER,
                                draws INTEGER, losses INTEGER)