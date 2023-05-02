require_relative 'student_list_super.rb'

class StudentListTXT < StudentListStrategy

  public_class_method :new

  def initialize(path)
    super
  end

  def write_to_file(path)
    raise ArgumentError, "Invalid path: #{path}" unless File.exist?(path)
    Student.white_to_txt(path, @students_list)
  end

  protected

  def init(path)
    raise ArgumentError, "Invalid path: #{path}" unless File.exist?(path)
    @students_list = Student.read_from_txt(path)
  end


end
