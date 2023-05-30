require 'sqlite3'

begin
  data_base_name = ARGV[0]
  table_name = ARGV[1]
  value = ARGV[2]
  db = SQLite3::Database.open "#{data_base_name}.db"
  db.execute "insert into #{table_name} values (#{value})"
rescue => ruby_error
  puts "Ruby error\n#{ruby_error}"
rescue SQLite3::Exception => sql_error
  puts "SQL error\n#{sql_error}"
end

system "ruby "