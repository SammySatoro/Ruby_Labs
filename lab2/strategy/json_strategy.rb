require_relative 'strategy'
require 'json'

class JSONStrategy
  include(Strategy)

  def write_to_file(path, data)
    raise ArgumentError, "Invalid path: #{path}" unless File.exist?(path)
    students_as_hashes = data.map(&:to_hash)

    File.open(path, 'w') do |file|
      file.write(JSON.pretty_generate(students_as_hashes))
    end
  end

  def read_from_file(path)
    raise ArgumentError, "Invalid path: #{path}" unless File.exist?(path)
    data = JSON.parse(File.read(path))
    data.map do |object|
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