
data_base_name = 'D:/RubyProject/App/SourceManagement/DBSystem/my_base'
table_name = 'Students'
table_struct = "id integer primary key autoincrement,
              last_name text,
              first_name text,
              patronymic text,
              git text,
              phone text,
              telegram text,
              email text"

students_quantity = 1000
system "ruby D:/RubyProject/App/SourceManagement/DBSystem/DBScripts/Manipulations/db_create.rb #{data_base_name}"
system "ruby D:/RubyProject/App/SourceManagement/DBSystem/DBScripts/Manipulations/db_add_table.rb #{data_base_name} #{table_name} '#{table_struct}'"
system "ruby D:/RubyProject/App/SourceManagement/DBSystem/DBScripts/FilledDB/db_insert_data_set.rb #{data_base_name} #{table_name} #{students_quantity}"
