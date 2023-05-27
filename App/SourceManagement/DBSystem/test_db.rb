require 'sqlite3'

connect = SQLite3::Database.open 'my_base.db'
connect.results_as_hash = false
arr = connect.execute "select * from Students limit 950, 1200"
arr.each { |hash| print "#{hash}\n" }
attr = "last_name, first_name, patronymic, git, phone, telegram, email"

#connect.execute "insert into Students (last_name, first_name, patronymic, git, phone, telegram, email) values ('Dmitry', 'Denis', 'Igorevich', null, null, null, null)"