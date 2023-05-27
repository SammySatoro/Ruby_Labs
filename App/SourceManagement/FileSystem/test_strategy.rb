require_relative 'file_content'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Manipulators/data_list_student_short.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Models/student.rb'

=begin
txt = StudentsListUnified.new('D:/RubyProject/LW_2/task_4/read_txt.txt')
txt.write_to_file('D:/RubyProject/LW_2/task_4/write_txt.txt')

json = StudentsListUnified.new('D:/RubyProject/LW_2/task_4/read_json.json')
json.write_to_file('D:/RubyProject/LW_2/task_4/write_json.json')

yaml = StudentsListUnified.new('D:/RubyProject/LW_2/task_4/read_yaml.yaml')
yaml.write_to_file('D:/RubyProject/LW_2/task_4/write_yaml.yaml')
=end

content = FileContent.new('D:\RubyProject\DoneApp\dataset.json')
=begin
exist_data_list = DataListStudentShort.new([])

data_list = content.get_k_n_student_short_list(100, 1001, exist_data_list)
data_table_obj = data_list.data

rows = data_table_obj.n_rows
columns = data_table_obj.n_columns
arr = []
(0...rows).each do |i|
  temp = []
  (0...columns).each { |j| temp << data_table_obj.get(i,j) }
  arr << temp
end
=end
#content.append(Student.from_hash({id:45,last_name:"Kot", first_name:"Dmitry", patronymic:'Olegovich'}))
#content.arr.each {|obj| print"#{obj}\n"}
#print "#{arr[1]}"
#arr.each { |obj| print "#{obj}\n" }

