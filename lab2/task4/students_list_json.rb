require_relative 'student_list_super.rb'
require 'json'

class StudentListJSON < StudentListStrategy

  public_class_method :new

  def initialize(path)
    super
  end

  def write_to_file(path)
    raise ArgumentError, "Invalid path: #{path}" unless File.exist?(path)
    students_as_hashes = @students_list.map(&:to_hash)

    File.open(path, 'w') do |file|
      file.write(JSON.pretty_generate(students_as_hashes))

    end
  end

  protected

  def init(path)
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


