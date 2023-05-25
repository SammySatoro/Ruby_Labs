require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/View/create_student_view.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Models/student.rb'

class CreateStudentController
  def initialize(senior_controller)
    @senior_controller = senior_controller
  end

  def append(entered_values)
    student_fields = [:id, :last_name, :first_name, :patronymic, :git, :phone, :telegram, :email]
    entered_values.unshift(@senior_controller.student_list_obj.id_count)
    obj = Student.from_hash(student_fields.zip(entered_values).to_h)
    @senior_controller.student_list_obj.append(obj)
    @senior_controller.refresh_data
  end
end
