require 'sqlite3'

begin
data_base_name = ARGV[0]
SQLite3::Database.new "#{data_base_name}.db"
rescue => ruby_error
puts "Ruby error\n#{ruby_error}"
rescue SQLite3::Exception => sql_error
puts "SQL error\n#{sql_error}"
end

