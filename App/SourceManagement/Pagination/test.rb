require_relative '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Manipulators/data_list_student_short.rb'
require_relative '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Manipulators/data_table.rb'
require_relative '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Models/student_short.rb'
require_relative 'data_list_pagination'


arr = []
(1..50).each { |item| arr.push StudentShort.new(item, 'Фамилия Имя Отчество, -, -')}
stud_list = DataListStudentShort.new(arr)
pagination = DataListPagination.convert(stud_list, 1, 25)
pagination.each { |obj| print "#{obj}\n"}