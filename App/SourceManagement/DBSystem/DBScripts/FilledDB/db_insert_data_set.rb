require 'sqlite3'
require 'D:\RubyProject\DoneApp\Models\student.rb'

def get_full_name
  {
      arr_last_name: IO.readlines('D:\RubyProject\DataSet\last_name.txt').map! { |el| el.chomp! },
      arr_first_name: IO.readlines('D:\RubyProject\DataSet\first_name.txt').map! { |el| el.chomp! },
      arr_patronymic: IO.readlines('D:\RubyProject\DataSet\patronymic.txt').map! { |el| el.chomp! }
  }
end

def create_students(quantity)
  values = get_full_name
  id_count = 10
  str_arr = []

  (1..quantity).each do |index|
    required_attr = "'#{values[:arr_last_name].sample}', '#{values[:arr_first_name].sample}', '#{values[:arr_patronymic].sample}'"
    optional_attr = "'https://github.com/User#{index}', null, '@user#{index}', 'something#{index}email@gmail.com'"
    str_arr.push "#{required_attr}, #{optional_attr}"
    id_count += 1
  end
  str_arr
end

def request_to_db(db_obj, table_name, array)
  attr =  "last_name, first_name, patronymic, git, phone, telegram, email"
  db_obj.transaction
  array.each { |str| db_obj.execute "insert into #{table_name} (#{attr}) values (#{str})" }
  db_obj.commit
end

db_name = ARGV[0]
table_name = ARGV[1]
quan_students = ARGV[2].to_i

db_obj = SQLite3::Database.open "#{db_name}.db"
values = create_students(quan_students)
request_to_db(db_obj, table_name, values)



