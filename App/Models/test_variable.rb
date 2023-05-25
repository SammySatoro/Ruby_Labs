require_relative 'student'
require_relative 'student_short'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Manipulators/data_table.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Manipulators/data_list_student_short.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Manipulators/data_list_laboratory_work.rb'
require_relative 'laboratory_work'
require_relative 'laboratory_work_light'

lw1 = LaboratoryWork.from_hash({name:'Паттерны', date_of_issue:'14.05.2023'})
lw_light1 = lw1.get_light_version
data_list = DataListLaboratoryWork.new([lw_light1])
data_table = data_list.data


rows = data_table.n_rows
columns = data_table.n_columns
arr = []
(0...rows).each do |i|
  temp = []
  (0...columns).each { |j| temp << data_table.get(i,j) }
  arr << temp
end

arr.each { |obj| print "#{obj}\n" }

