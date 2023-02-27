# frozen_string_literal: true

require_relative 'student'

def create_students
  [
    Student.new(surname: 'sn', first_name: 'fn', patronymic: 'pn', phone_number: '+12345678910'),
    Student.new(surname: 'sn1', first_name: 'fn1', patronymic: 'pn1', phone_number: '+12345678911',
                git: 'https://github.com/funfyric'),
    Student.new(surname: 'sn2', first_name: 'fn2', patronymic: 'pn2', phone_number: '+12345678912',
                email: 'lalala@mail.ru'),
    Student.new(surname: 'sn3', first_name: 'fn3', patronymic: 'pn3', id: 1)
  ]
end

#create_students.each { |student| print student, "\n" }

s = Student.new(surname: 'sn', first_name: 'fn', patronymic: 'pn', phone_number: '+12345678910')
puts s
s.phone_number = '1'
puts s