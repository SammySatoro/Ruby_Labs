require_relative 'strategy'
require 'yaml'

class YAMLStrategy
  include Strategy

  def write_to_file(path, data)
    raise ArgumentError, "Invalid path: #{path}" unless File.exist?(path)
    students_as_hashes = data.map(&:to_hash)

    File.open(path, 'w') do |file|
      file.write(students_as_hashes.to_yaml)
    end
  end

  def read_from_file(path)
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
end