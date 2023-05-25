require_relative 'select_changeable_controller'
require 'glimmer-dsl-libui'

class SelectChangeableViewTest
  include Glimmer

  def initialize(main_view=nil, senior_controller=nil)
    @main_view = main_view
    @controller = SelectChangeableController.new(senior_controller)
  end

  def display
    @select_window = window('Что будем менять?', 400, 150) { |wind|
      margined true
      vertical_box {
        button('ФИО') {
          on_clicked do
            wind.destroy
            @controller.create_update_window(:full_name_window)
          end
        }

        button('Git'){
          on_clicked do
            wind.destroy
            @controller.create_update_window(:git_window)
          end
        }

        button('Контакты'){
          on_clicked do
            wind.destroy
            @controller.create_update_window(:contacts_window)
          end
        }
      }
    }.show
  end
end

SelectChangeableView.new.display
