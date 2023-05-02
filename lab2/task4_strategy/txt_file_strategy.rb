require_relative 'file_strategy'
require_relative '../task2/student.rb'
class TxtFileStrategy
  include FileStrategy

  def read_from_file(path)
    raise ArgumentError, "Invalid path: #{path}" unless File.exist?(path)
    object_array = []
    arr = IO.readlines(path)
    arr.map! { |str|str.chomp }
    arr.each_with_index do |str, index|
      temp_obj = Student.from_string(index, str)
      object_array.push(temp_obj)
    end

    object_array
  end

  def write_to_file(path, data)
    txt_file = File.open(path, 'w')
    data.each do |student|
      temp_str = ""
      student.to_hash.each { |_, value|
        temp_str += "#{value == nil ? '-' : value}, "
      }
      txt_file.write("#{temp_str}\n")
    end
    txt_file.close
  end

end