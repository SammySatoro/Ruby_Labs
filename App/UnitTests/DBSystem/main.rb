require_relative 'db_adapter_test'
require_relative 'student_list_test'

db_adapter = DBAdapterTest.new
stud_list = StudentListTest.new(db_adapter)

=begin
data_list = db_adapter.get_k_n_student_short_list(1, 10)
data_table_obj = data_list.data
rows = data_table_obj.n_rows
columns = data_table_obj.n_columns
arr = []
(0...rows).each do |i|
  temp = []
  (0...columns).each { |j| temp << data_table_obj.get(i,j) }
  arr << temp
end

arr.each { |obj| print "#{obj}\n" }
=end

data_list = stud_list.get_k_n_student_short_list(1, 10, nil, {git: false })
data_table_obj = data_list.data
rows = data_table_obj.n_rows
columns = data_table_obj.n_columns
arr = []
(0...rows).each do |i|
  temp = []
  (0...columns).each { |j| temp << data_table_obj.get(i,j) }
  arr << temp
end

arr.each { |obj| print "#{obj}\n" }