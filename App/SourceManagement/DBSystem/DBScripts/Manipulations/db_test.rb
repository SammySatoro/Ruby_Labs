require 'sqlite3'

db = SQLite3::Database.open "my_base.db"
db.results_as_hash = true
res = db.execute 'select * from Students'

res.each { |obj| print "#{obj}\n" }