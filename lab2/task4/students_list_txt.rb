require_relative 'student_list_super.rb'

class StudentListTXT < StudentListSuper

  public_class_method :new

  def initialize(path)
    super
  end

  def init(path)
    raise ArgumentError, "Invalid path: #{path}" unless File.exist?(path)
    @students_list = Student.read_from_txt(path)
  end

  def write_to_file(path)
    raise ArgumentError, "Invalid path: #{path}" unless File.exist?(path)
    Student.white_to_txt(path, @students_list)
  end


end

slt = StudentListTXT.new('lab2/task2/students_set.txt')
# slt.sort_by_full_name!(:asc)
test = Student.from_string(40, 'Here, Ewq, Weq, https://github.com/SammySatoro, +7-918-334-32-58, -, -')
slt.add(test)
slt.write_to_file('lab2/task2/output_file.txt')
puts slt.students_count
