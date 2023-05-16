require_relative 'file_strategy'
require 'json'

class JsonFileStrategy
  include FileStrategy

  def read_from_file(path)
    raise ArgumentError, "Invalid path: #{path}" unless File.exist?(path)
    object_list = []
    data = JSON.parse(File.read(path))
    data.map do |object|
      new_object = object.map do |key, value|
        [
          key.to_sym,
          value == '-' ? nil : value
        ]
      end.to_h
      object_list << new_object
    end
    object_list
  end

  def write_to_file(path, data)
    raise ArgumentError, "Invalid path: #{path}" unless File.exist?(path)
    unless data === Hash
      data.map! { |object| object.to_hash}
    end
    File.open(path, 'w') do |file|
      file.write(JSON.pretty_generate(data))

    end
  end

end