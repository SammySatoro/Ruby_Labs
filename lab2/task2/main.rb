# frozen_string_literal: true
require_relative 'student'
require_relative 'short_student'


students = Student.read_from_txt('lab2/students_set.txt')
students.each { |student| puts student.get_info}


Student.white_to_txt('lab2/output_file.txt', students)

