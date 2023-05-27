
class DeleteLWController
  def initialize(main_view, senior_controller)
    @main_view = main_view
    @senior_controller = senior_controller
  end

  def delete
    number = @main_view.table_zone.selection + 1
    @senior_controller.lw_folder.delete_by_number(number)
    @senior_controller.refresh_data
  end
end
