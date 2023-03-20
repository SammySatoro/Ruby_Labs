require_relative 'student'

class StudentShort
  attr_reader :id, :short_name, :git, :contact

  def initialize(student_object)
    raise ArgumentError, '\'student_object\' must be Student type' unless student_object.is_a? Student

    @id = student_object.id
    @short_name = student_object.initials
    @git = student_object.git
    @contact = student_object.contact_data.values[0]
  end

  def self.from_string(string)
    new(Student.from_string(string))
  end

  def to_s
    "ID: #{@id} Short name: #{@short_name} GIT: #{@git} Contact: #{@contact}"
  end
end

