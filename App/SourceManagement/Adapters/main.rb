require_relative 'db_adapter'
require_relative 'db_adapter_for_lw'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Models/laboratory_work.rb'

=begin
test1 = DBAdapter.new
data_list = test1.get_k_n_student_short_list(2, 50) # c 51 по 100
result_self = DataListPagination.convert(data_list, 1, 25)
result_comp = test1.get_k_n_student_short_list(1, 25, data_list) # 51 - 75
=end

=begin
adapter_one = DBAdapter.new
data_list = DataListStudentShort.new([])
adapter_one.get_k_n_student_short_list(1, 10, data_list)

data_table = data_list.data
matrix = []

(0...data_table.n_rows).each do |i|
  temp = []
  (0...data_table.n_columns).each { |j| temp << data_table.get(i, j) }
  matrix << temp
end

=end

db_for_lw = DBAdapterForLW.new
#print db_for_lw.get_by_number(10)
#print db_for_lw.get_lw_count
#db_for_lw.delete_by_number(10)
#db_for_lw.append(LaboratoryWork.from_hash({number:10, name:'Мат моделирование', date_of_issue:"28.05.2009"}))
#lw = LaboratoryWork.from_hash({number:10, name:'Мат моделирование', date_of_issue:"28.05.2009"}).to_hash
#db_for_lw.replace_by_number(5, lw)

=begin
data_table = db_for_lw.get_all_lw.data
matrix = []

(0...data_table.n_rows).each do |i|
  temp = []
  (0...data_table.n_columns).each { |j| temp << data_table.get(i, j) }
  matrix << temp
end
matrix.each { |obj| print"#{obj}\n" }
=end
a = Date.strptime('28.04.2004', '%d.%m.%Y')
b = a.strftime('%d.%m.%Y')
print b.class