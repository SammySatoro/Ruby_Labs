require 'sqlite3'

db = SQLite3::Database.open "D:/RubyProject/LW_3/my_base.db"
db.close