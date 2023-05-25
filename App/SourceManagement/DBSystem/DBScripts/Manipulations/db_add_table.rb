require 'sqlite3'

begin
data_base_name = ARGV[0]
table_name = ARGV[1]
table_attr = ARGV[2]
db = SQLite3::Database.open "#{data_base_name}.db"
db.execute "create table if not exists #{table_name} (#{table_attr})"
rescue SQLite3::Exception => sql_error
  puts "SQL error\n#{sql_error}"
rescue => ruby_error
  puts "Ruby error\n#{ruby_error}"
end

