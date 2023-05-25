require_relative 'student_super'

class StudentShort < StudentSuper

  public_class_method :new

  attr_accessor :full_name
  attr_reader :contact

  def StudentShort.from_object(obj)
    new(obj.id, obj.get_info)
  end

  def initialize(id, str)
    decompose_str = str.split(', ')
    self.id = id
    self.full_name = decompose_str[0]
    self.git = decompose_str[1] == '-' ? nil : decompose_str[1]
    self.contact = decompose_str[2]
  end

  def contact=(value)
    arr = value.split(':')
    @contact = {arr[0].to_sym => arr [1]}
  end
end
