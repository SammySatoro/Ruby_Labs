require 'sqlite3'

begin
data_base_name = ARGV[0]
table_name = ARGV[1]
db = SQLite3::Database.open "#{data_base_name}.db"
db.execute "drop table #{table_name}"
rescue => ruby_error
puts "Ruby error\n#{ruby_error}"
rescue SQLite3::Exception => sql_error
puts "SQL error\n#{sql_error}"
end
