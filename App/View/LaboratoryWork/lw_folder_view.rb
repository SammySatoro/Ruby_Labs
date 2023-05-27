require 'glimmer-dsl-libui'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Controllers/LaboratoryWork/lw_folder_controller.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Controllers/LaboratoryWork/delete_lw_controller.rb'
require_relative 'create_lw_view'
require_relative 'update_lw_view'

class LWFolderView
  include Glimmer

  attr_reader :arr, :table_zone

  def initialize
    @controller = LWFolderController.new(self)
  end

  def create
    @lw_tab = tab_item('Лабораторные работы') {
      grid {
        @table_zone = table { |table|
          hexpand true
          vexpand true
          xspan 1
          sortable false
          selection_mode :zero_or_one
          text_column('№')
          text_column('Наименование')
          text_column('Дата выдачи')
          cell_rows <= [self, :arr, column_attributes:
            {'№' => :arr[0], 'Наименование' => :arr[1], 'Дата выдачи' => :arr[2]}]

          on_selection_changed do |tbl, selection, added_selection, removed_selection|
            if selection.is_a?(Integer)
              if tbl.cell_rows[selection] == tbl.cell_rows.last
                @delete_button.enabled = true
                @update_button.enabled = true
              else
                @delete_button.enabled = false
                @update_button.enabled = true
              end
            end
          end
        }

        vertical_box {
          left 1
          hexpand true
          vexpand true

          button('Добавить') {
            on_clicked do
              @create_lw_view = CreateLWView.new(@controller).display
            end
          }

          @update_button = button('Изменить') { |but|
            but.enabled = false
            on_clicked do
              @update_lw_view = UpdateLWView.new(self, @controller).display
            end

          }
          @delete_button = button('Удалить') { |but|
            but.enabled = false
            on_clicked do
              @delete_controller = DeleteLWController.new(self, @controller).delete
            end
          }
          @refresh_button = button('Обновить') {
            on_clicked do
              @table_zone.selection = []
              @update_button.enabled = false
              @controller.refresh_data
            end
          }
        }

        horizontal_box {
          top 1
          hexpand true
          button() {visible false }
          button() {visible false }
          button() {visible false }
          button() {visible false }
        }
      }
    }
    @controller.on_lw_folder_view_created
    @controller.refresh_data
  end

  def update(data_table_obj)
    begin
    rows = data_table_obj.n_rows
    columns = data_table_obj.n_columns
    arr = []
    (0...rows).each do |i|
      temp = []
      (0...columns).each { |j| temp << data_table_obj.get(i,j) }
      arr << temp
    end
    @table_zone.cell_rows = arr
    rescue => error
      print "#{error}"
    end
  end
end
