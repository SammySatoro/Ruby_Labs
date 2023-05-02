require_relative 'txt_file_strategy'
require_relative 'json_file_strategy'
require_relative 'yaml_file_strategy'

class FileManager

  def FileManager.import_from_file(path)
    self.set_strategy(path)
    @current_strategy.read_from_file(path)
  end

  def FileManager.export_to_file(path, data)
    self.set_strategy(path)
    @current_strategy.write_to_file(path, data)
  end

  def self.set_strategy(path)
    case File.extname(path)
    when '.txt'
      @current_strategy = TxtFileStrategy.new
    when '.json'
      @current_strategy = JsonFileStrategy.new
    when '.yaml'
      @current_strategy = YamlFileStrategy.new
    else
      raise "The directory doesn't exist!"
    end
  end

end