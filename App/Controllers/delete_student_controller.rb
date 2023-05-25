require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/View/student_list_view.rb'

class DeleteStudentController
  def initialize(main_view, senior_controller)
    @main_view = main_view
    @senior_controller = senior_controller
  end

  def delete
    id_arr = get_id_arr
    id_arr.each { |id| @senior_controller.student_list_obj.delete_by_id(id) }
    if (@main_view.table_zone.cell_rows.length) == 1
      @main_view.current_page -= 1
      @senior_controller.refresh_data
    else
      @senior_controller.refresh_data
    end
  end

  protected

  def get_id_arr
    selected_students = @main_view.table_zone.selection
    selected_students.map! { |number| number + 1 }
    selected_students.each { |number| @senior_controller.data_list_obj.sel(number) }
    id_arr = @senior_controller.data_list_obj.get_selected
    @senior_controller.data_list_obj.clear_selected
    id_arr
  end
end
