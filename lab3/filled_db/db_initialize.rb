
data_base_name = 'my_base'
table_name = 'Students'
table_struct = "id integer primary key autoincrement,
              last_name text,
              first_name text,
              patronymic text,
              git text,
              phone text,
              telegram text,
              email text"
students_quantity = 100
system "ruby /home/sammysatoro/RubyProjects/Ruby_Labs/lab3/db_file/db_create.rb #{data_base_name}"
system "ruby /home/sammysatoro/RubyProjects/Ruby_Labs/lab3/db_file/db_add_table.rb #{data_base_name} #{table_name} '#{table_struct}'"
system "ruby /home/sammysatoro/RubyProjects/Ruby_Labs/lab3/filled_db/db_insert_data_set.rb #{data_base_name} #{table_name} #{students_quantity}"
