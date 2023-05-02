require_relative 'student_list_strategy.rb'

# sl_json = StudentListJSON.new('lab2/task4/students_set.json')
# sl_yaml = StudentListYAML.new('lab2/task4/students_set.yaml')
# sl_txt = StudentListTXT.new('lab2/task2/students_set.txt')
#
#
#
#
# sl_json.write_to_file('lab2/task4/output_file.json')
# sl_yaml.write_to_file('lab2/task4/output_file.yaml')
# sl_txt.write_to_file('lab2/task2/output_file.txt')

sls = StudentListStrategy.new('lab2/task4/students_set.json')

sls.export_to_file('lab2/task4/output_file.yaml')

