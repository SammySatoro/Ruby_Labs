require_relative 'student_list_super.rb'
require 'yaml'

class StudentListYAML < StudentListSuper

  public_class_method :new

  def initialize(path)
    super
  end

  def init(path)
    raise ArgumentError, "Invalid path: #{path}" unless File.exist?(path)
    yaml_data = YAML.load_file(path)
    yaml_data.map do |object|
      new_object = object.map do |key, value|
        [
          key.to_sym,
          value == '-' ? nil : value
        ]
      end.to_h
      Student.from_hash(new_object)
    end
  end

  def write_to_file(path)
    raise ArgumentError, "Invalid path: #{path}" unless File.exist?(path)
    students_as_hashes = @students_list.map { |student| student.to_hash }

    File.open(path, 'w') do |file|
      file.write(students_as_hashes.to_yaml)
    end
  end

end

slt = StudentListYAML.new('lab2/task4/students_set.yaml')
slt.sort_by_full_name!(:asc)
test = Student.from_string(40, 'Here, Ewq, Weq, https://github.com/SammySatoro, +7-918-334-32-58, -, -')
slt.add(test)
slt.write_to_file('lab2/task4/output_file.yaml')
puts slt.students_count
