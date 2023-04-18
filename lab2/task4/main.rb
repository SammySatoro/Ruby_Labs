require_relative 'students_list_json'
require_relative 'students_list_yaml'
require_relative 'students_list_txt'


sl_json = StudentListJSON.new('lab2/task4/students_set.json')
sl_yaml = StudentListYAML.new('lab2/task4/students_set.yaml')
sl_txt = StudentListTXT.new('lab2/task2/students_set.txt')




sl_json.write_to_file('lab2/task4/output_file.json')
sl_yaml.write_to_file('lab2/task4/output_file.yaml')
sl_txt.write_to_file('lab2/task2/output_file.txt')


