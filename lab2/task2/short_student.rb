require_relative 'super_student'
require_relative '../task2/student_regexes'

class StudentShort < SuperStudent

  public_class_method :new

  attr_accessor :full_name, :contact

  def StudentShort.from_object(student_object)
    new(student_object.id, student_object.get_info)
  end

  def initialize(id, str)
    values_str = str.split(FROM_STRING_REGEX)
    self.id = id
    self.full_name = values_str[0..2].join(' ')
    self.git = values_str[3] == '-' ? nil : values_str[3]
    self.contact = values_str[4] == '-' ? nil : values_str[4]
  end

end


