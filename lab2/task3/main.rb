require_relative '../task2/student.rb'
require_relative '../task2/short_student.rb'
require_relative 'data_list_student_short.rb'
require_relative 'data_table'

test1 = Student.from_string(10, 'Стрелков, Игорь, Иванович, https://github.com/SammySatoro, +7-918-334-32-58, -, -')
test2 = Student.from_string(20, 'Гиркин, Игорь, Всеволодович, https://github.com/tyagi_barhatnye, -, @pupupu, -')
test3 = Student.from_string(30, 'Стронг, Эмиль, Дмитриевич, https://github.com/yoBN_M, -, -, kefteme@gmail.com')
test4 = StudentShort.from_object(test1)
test5 = StudentShort.from_object(test2)
test6 = StudentShort.from_object(test3)

student_arr = [test4, test5, test6]

data_list = DataListStudentShort.new(student_arr)

puts "get_selected\n"
data_list.add_to_selection(2)
print "#{data_list.get_selected}\n"

data_list.add_to_selection([0, 1, 2])
print "#{data_list.get_selected}\n"

data_list.clear_selected
data_list.add_to_selection([2, 1, 0])
print "#{data_list.get_selected}\n"

puts 'get_names'
data_list.names.each { |attr| puts "#{attr[0]} #{attr[1]}" }

data_table = data_list.data
print "class: #{data_table.class}\nrows: #{data_table.rows_size}\ncolumns: #{data_table.columns_size}\n"


rows = data_table.rows_size
columns = data_table.columns_size

(0...rows).each do |row|
  (0...columns).each { |col| print(data_table.item(row, col),' ')}
  puts
end

print DataTable.instance_variables