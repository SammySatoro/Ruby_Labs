require 'glimmer-dsl-libui'
require_relative 'student_list_view.rb'

class MainWindow
  include Glimmer

  def initialize
    @student_list_view = StudentListView.new
  end

  def display
    window("My App", 1600, 600) {
      margined true

      tab {
        @student_list_view.create
        tab_item('Вкладка 2')
        tab_item('Вкладка 3')
      }
    }.show
  end
end

MainWindow.new.display
