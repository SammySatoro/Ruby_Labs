
class UpdateStudentController

  def initialize(update_view, main_view, senior_controller)
    @current_view = update_view
    @main_view = main_view
    @senior_controller = senior_controller
  end

  def fill_view
    @student_obj = get_student_object
    student_str = @student_obj.to_s.split(', ')
    glimmer_objects = get_entry + get_label
    (0...student_str.length).each { |item| glimmer_objects[item].text = student_str[item] }
    @current_view.student_form.show
  end

  def update(full_name_arr)
    @student_obj.last_name = full_name_arr[0]
    @student_obj.first_name = full_name_arr[1]
    @student_obj.patronymic = full_name_arr[2]
    @senior_controller.student_list_obj.replace_by_id(@student_obj.id, @student_obj)
    @senior_controller.refresh_data
  end

  protected

  def get_student_object
    selected_number = @main_view.table_zone.selection.shift + 1
    @main_view.data_list.sel(selected_number)
    student_obj = @senior_controller.student_list_obj.get_by_id(@main_view.data_list.get_selected.shift)
    @main_view.data_list.clear_selected
    student_obj
  end

  def get_entry
    arr_entry_obj = @current_view.instance_variables.select { |var| var.to_s.end_with?('entry') }
    arr_entry_obj.map! { |sym| @current_view.instance_variable_get(sym) }
  end

  def get_label
    arr_label_obj = @current_view.instance_variables.select { |var| var.to_s.end_with?('label') }
    arr_label_obj.map! { |sym| @current_view.instance_variable_get(sym) }
  end

end
