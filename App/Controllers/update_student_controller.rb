
class UpdateStudentController

  def initialize(update_view, main_view, senior_controller)
    @current_view = update_view
    @main_view = main_view
    @senior_controller = senior_controller
  end

  def fill_view
    begin
    @student_obj = get_student_object
    @current_view.view_from_attr.each_pair do |attr, glimmer_obj|
      glimmer_obj.text = @student_obj.send(attr)
    end
    @current_view.update_window.show
    rescue => error
      print "I'm here fill_view\n#{error}"
    end
  end

  def update(fields_hash)
    begin
    fields_hash.each_pair { |key, values| @student_obj.send("#{key}=".to_sym, values) }
    @senior_controller.student_list_obj.replace_by_id(@student_obj.id, @student_obj)
    @senior_controller.refresh_data
    rescue => error
      print "I'm here update\n#{error}"
    end
  end

  protected

  def get_student_object
    if @main_view.table_search_clone.nil?
      number = @main_view.table_zone.selection.shift + 1
      @senior_controller.data_list_obj.sel(number)
      student_obj = @senior_controller.student_list_obj.get_by_id(@senior_controller.data_list_obj.get_selected.shift)
      @senior_controller.data_list_obj.clear_selected
      student_obj
    else
      number_selected_student = @main_view.table_zone.selection.shift
      arr_selected_student = @main_view.table_zone.cell_rows[number_selected_student]
      number_in_source = find_in_source(arr_selected_student)
      @senior_controller.data_list_obj.sel(number_in_source)
      student_obj = @senior_controller.student_list_obj.get_by_id(@senior_controller.data_list_obj.get_selected.shift)
      @senior_controller.data_list_obj.clear_selected
      student_obj
    end
  end

  def find_in_source(obj)
    @main_view.table_search_clone.index(obj) + 1
  end
end
