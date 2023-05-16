require_relative 'students_list_json'
require_relative 'students_list_yaml'
require_relative 'students_list_txt'
require_relative 'student_list_strategy'

sl = StudentListStrategy.new('lab2/task4/students_set.json')
sl.write_to_file()





