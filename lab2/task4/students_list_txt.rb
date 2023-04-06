require_relative '../task2/student.rb'
require_relative '../task3/data_list_student_short'
require_relative '../task2/short_student'

class StudentListTXT

  attr_accessor :students_list

  def initialize(path)
    self.students_list = read_from_txt(path)

  end

  def read_from_txt(path)
    @students_list = Student.read_from_txt(path)
  end

  def write_to_txt(path)
    Student.white_to_txt(path, @students_list)
  end

  def student_by_id(id)
    @students_list.find { |obj| obj.id == id.to_s }
  end

  # def get_k_n_student_short_list(from, quantity, data_list=nil)
  #
  #   if data_list
  #     raise ArgumentError, "DataListStudentShort object should be passed! data_list class: #{data_list.class}" unless
  #       data_list.is_a?(DataListStudentShort)
  #
  #   end
  #
  # end

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

end

slt = StudentListTXT.new('lab2/task2/students_set.txt')
slt.sort_by_full_name!(:asc)
test = Student.from_string(40, 'Qwe, Ewq, Weq, https://github.com/SammySatoro, +7-918-334-32-58, -, -')
slt.add(test)
slt.write_to_txt('lab2/task2/output_file.txt')
puts slt.get_k_n_student_short_list(1, 2).data
