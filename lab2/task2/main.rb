# frozen_string_literal: true
require_relative 'student'

students = Student.read_from_txt('lab2/task2/students_set.txt')
students.each { |student| puts student.get_info}


Student.white_to_txt('lab2/task2/output_file.txt', students)

