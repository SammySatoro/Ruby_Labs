require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Models/laboratory_work.rb'

class CreateLWController

  attr_reader :current_number

  def initialize(create_view, senior_controller)
    @create_view = create_view
    @senior_controller = senior_controller
  end

  def fill_view
    @current_number = @senior_controller.lw_folder.count_number
    @create_view.number_label.text = @current_number.to_s
    @create_view.create_window.show
  end

  def append(entered_values)
    lw_fields = [:number, :name, :themes, :list_of_tasks, :date_of_issue]
    entered_values.unshift(@current_number)
    obj = LaboratoryWork.from_hash( lw_fields.zip(entered_values).to_h)
    @senior_controller.lw_folder.append(obj)
    @senior_controller.refresh_data
  end

  def valid_date_of_issue?(current_date)
    last_date = @senior_controller.lw_folder.last_date_of_issue
    Date.strptime(last_date, '%d.%m.%Y') < Date.strptime(current_date, '%d.%m.%Y')
  end
end
