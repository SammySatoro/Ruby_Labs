require_relative '../task2/student.rb'
require_relative '../task3/data_list_student_short'
require_relative '../task2/short_student'
require 'yaml'

class StudentListYAML

  attr_accessor :students_list

  def initialize(path)
    self.students_list = read_from_yaml(path)

  end

  def read_from_yaml(path)
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

  def write_to_yaml(path)
    raise ArgumentError, "Invalid path: #{path}" unless File.exist?(path)
    students_as_hashes = @students_list.map { |student| student.to_hash }

    File.open(path, 'w') do |file|
      file.write(students_as_hashes.to_yaml)
    end
  end

  def student_by_id(id)
    @students_list.find { |obj| obj.id == id.to_s }
  end

  def get_k_n_student_short_list(start_from, quantity, data_list = nil)
    short_students = @students_list.map {|obj| StudentShort.from_object(obj)}
    data_list ||= DataListStudentShort.new(short_students)
    start_index = start_from
    end_index = start_index + quantity
    data_list.list = short_students[start_index...end_index]

    data_list
  end

  def sort_by_full_name!(order = :asc)
    self.students_list.sort_by! { |obj| [obj.surname, obj.first_name, obj.patronymic]}
    if order == :desc
      @students_list.reverse!
    end
  end

  def add(object)
    unless object.is_a?(Student)
      raise ArgumentError, 'You can only add objects of the Student class to the list!'
    end

    max_id = @students_list.map(&:id).map(&:to_i).max || 0
    new_id = (max_id + 1).to_s

    object.id = new_id
    @students_list << object
  end

  def replace(id, object)
    unless object.is_a?(Student)
      raise ArgumentError, 'You can only replace with objects of the Student class!'
    end

    index = @students_list.find_index { |student| student.id == id.to_s }

    raise ArgumentError, "The list doesn't contain Student with a such ID' unless" unless index

    @students_list[index] = object
    nil
  end

  def delete(id)
    index = @students_list.find_index { |student| student.id == id.to_s }

    raise ArgumentError, "The list doesn't contain Student with a such ID' unless" unless index

    @students_list.delete_at(index)
    nil
  end

  def students_count
    @students_list.length
  end

end

