
class UpdateLWController

  def initialize(update_view, main_view, senior_controller)
    @update_view = update_view
    @main_view = main_view
    @senior_controller = senior_controller
  end

  def fill_view
    @lw_obj = get_lw_object
    values = @lw_obj.to_hash.values
    values.shift
    all_entry = get_entry.unshift(@update_view.number_label)
    (0...values.length).each { |item| all_entry[item].text = values[item].to_s }
  end

  def update(entered_values)
    lw_fields = [:name, :themes, :list_of_tasks, :date_of_issue].zip(entered_values).to_h
    lw_fields.each_pair { |filed, value| @lw_obj.send("#{filed}=", value) }
    @senior_controller.lw_folder.replace_by_number(@lw_obj.number, @lw_obj)
    @senior_controller.refresh_data
  end

  def find_case(current_date)
    cur_numb = @lw_obj.number
    if !exist?(cur_numb - 1) && !exist?(cur_numb + 1)
      nil
    elsif exist?(cur_numb - 1) && !exist?(cur_numb + 1)
      date(cur_numb - 1) < Date.strptime(current_date, '%d.%m.%Y') ? nil : "Дата выдачи текущей ЛР должна быть больше #{date(cur_numb - 1).strftime('%d.%m.%Y')}"
    elsif !exist?(cur_numb - 1) && exist?(cur_numb + 1)
      Date.strptime(current_date, '%d.%m.%Y') < date(cur_numb + 1) ? nil : "Дата выдачи текущей ЛР должна быть меньше #{date(cur_numb + 1).strftime('%d.%m.%Y')}"
    elsif exist?(cur_numb - 1) && exist?(cur_numb + 1)
      date(cur_numb - 1) < Date.strptime(current_date, '%d.%m.%Y') && Date.strptime(current_date, '%d.%m.%Y') < date(cur_numb + 1) ? nil : "Дата выдачи текущей ЛР должна быть больше #{date(cur_numb - 1).strftime('%d.%m.%Y')} и меньше #{date(cur_numb + 1).strftime('%d.%m.%Y')}"
    end
  end

  protected

  def exist?(number)
    !@senior_controller.lw_folder.get_by_number(number).nil?
  end

  def date(number)
    obj = @senior_controller.lw_folder.get_by_number(number)
    Date.strptime(obj.date_of_issue, '%d.%m.%Y')
  end

  def get_lw_object
    number = @main_view.table_zone.selection + 1
    @senior_controller.data_list.sel(number)
    lw_obj = @senior_controller.lw_folder.get_by_number(@senior_controller.data_list.get_selected)
    @senior_controller.data_list.clear_selected
    lw_obj
  end

  def get_entry
    all_entry = @update_view.instance_variables.select { |var| var.to_s.end_with?('entry') }
    all_entry.map! { |sym| @update_view.instance_variable_get(sym) }
  end
end
