require_relative 'file_proc_strategy'
require 'json'

class JsonFileStrategy
  include FileProcStrategy

  def read_from_file(path)
    object_array = []
    begin
      count_obj = 1
      str = IO.read(path).chomp
      hash_arr = JSON.parse(str,{symbolize_names: true})
      hash_arr.each do |hash|
        hash[:id] = count_obj
        temp_obj = Student.from_hash(hash)
        object_array.push(temp_obj)
        count_obj += 1
      end
    rescue SystemCallError
      puts 'Не найден файл по заданному пути!'
    rescue => error
      puts "#{error}\n№ Объекта: #{count_obj}"
    end
    object_array
  end

  def write_to_file(path, data)
    begin
      temp = data.map { |obj| obj.as_hash }
      temp.each { |hash| hash.delete('id') }
      File.open(path, 'w') do |file|
        file.write JSON.pretty_generate(temp)
      end
    rescue SystemCallError
      puts 'Не найден файл по заданному пути!'
    rescue => error
      puts error
    end
  end

end
