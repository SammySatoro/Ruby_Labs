require_relative '../task2/student'
require_relative 'strategy'
class TXTStrategy
  module Strategy

  end
  def write_to_file(path, data)
    raise ArgumentError, "Invalid path: #{path}" unless File.exist?(path)
    Student.white_to_txt(path, data)
  end

  def read_from_file(path)
    raise ArgumentError, "Invalid path: #{path}" unless File.exist?(path)
    @students_list = Student.read_from_txt(path)
  end

end