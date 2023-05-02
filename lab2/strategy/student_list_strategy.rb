require_relative '../task2/student.rb'
require_relative '../task2/short_student'
require_relative '../task3/data_list_student_short'
require_relative 'json_strategy'
require_relative 'yaml_strategy'
require_relative 'txt_strategy'
require_relative 'file_manager'

class StudentListStrategy
  include FileManager


  def path=(value)
    @path = value
    set_strategy
    @data = @strategy.read_from_file
  end

  private
  def set_strategy
    case File.extname(@path)
    when '.txt'
      @strategy = TXTStrategy.new @path
    when '.json'
      @strategy = JSONStrategy.new @path
    when '.yaml'
      @strategy = YAMLStrategy.new @path
    else
      raise "Unknown file type"
    end
  end

end