# frozen_string_literal: true

require 'glimmer-dsl-libui'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Controllers/student_list_controller'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Controllers/data_list_contract'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Manipulators/data_table'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Controllers/delete_student_controller'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/View/UpdateStudent/select_changeable_view'
require_relative 'create_student_view'

class StudentListView
  include Glimmer
  include DataListContract

  attr_accessor :arr, :current_page
  attr_reader :quan_rows, :table_zone, :table_search_clone

  def initialize
    @controller = StudentListController.new(self)

    @current_page = 1
    @quan_rows = 10

    @column_full_name_states = [:ascending, :descending, nil]
    @column_full_name_count = 0

    @full_name_sort_clone
    @table_search_clone

    @filters = {}
  end

  def create
    @students_tab = tab_item('Список студентов') do
      vertical_box do
        @pagination_zone = horizontal_box do
          stretchy false

          @previous_button = button('<') do
            stretchy false
            on_clicked do
              if @current_page > 1
                @current_page -= 1
                @full_name_column.sort_indicator = nil
                @full_name_sort_clone = nil
                @table_search_clone = nil
                @column_full_name_count = 3
                @pagination_label.text = "Страница № #{@current_page} из #{quan_pages(@total_count, @quan_rows)}"
                @controller.refresh_data(@current_page, @quan_rows, @filters)
              end
            end
          end

          @next_button = button('>') do
            stretchy false
            on_clicked do
              if @current_page && @quan_rows.positive?
                if (@total_count % @quan_rows).zero?
                  if @current_page < @total_count / @quan_rows
                    @current_page += 1
                    @full_name_column.sort_indicator = nil
                    @full_name_sort_clone = nil
                    @table_search_clone = nil
                    @column_full_name_count = 3
                    @pagination_label.text = "Страница № #{@current_page} из #{quan_pages(@total_count, @quan_rows)}"
                    @controller.refresh_data(@current_page, @quan_rows, @filters)
                  end
                elsif @current_page <= @total_count / @quan_rows
                  @current_page += 1
                  @full_name_column.sort_indicator = nil
                  @full_name_sort_clone = nil
                  @table_search_clone = nil
                  @column_full_name_count = 3
                  @pagination_label.text = "Страница № #{@current_page} из #{quan_pages(@total_count, @quan_rows)}"
                  @controller.refresh_data(@current_page, @quan_rows, @filters)
                end
              end
            end
          end

          label('Количество строк') { stretchy false }

          @pagination_entry = entry do |en|
            stretchy false
            en.enabled = false
            on_changed do |entry|
              if entry.text == '' || entry.text == '0'
                @current_page = 0
                @quan_rows = 0
                @pagination_label.text = "Страница № #{@current_page} из #{@quan_rows}"
                @table_zone.cell_rows = Array.new(5) { [] }
              elsif en.text.match?(/\b\d+\b/)
                @current_page = 1
                @quan_rows = entry.text.to_i
                @pagination_label.text = "Страница № #{@current_page} из #{quan_pages(@total_count, @quan_rows)}"
                @controller.refresh_data(@current_page, @quan_rows, @filters)
              end
            end
          end

          @pagination_label = label('Страница № 0 из 0')
        end

        @table_zone = table do |table|
          sortable false
          selection_mode :zero_or_many

          text_column('№')

          @full_name_column = text_column('ФИО') do
            on_clicked do |column|
              @full_name_sort_clone ||= table.cell_rows
              state = column_state
              column.sort_indicator = state
              table.cell_rows = sort_by_name(table.cell_rows, state)
            end
          end

          text_column('Git')
          text_column('Контакт')

          cell_rows <= [self, :arr, { column_attributes: { '№' => :arr[0],
                                                           'ФИО' => :arr[1],
                                                           'Git' => :arr[2],
                                                           'Контакт' => :arr[3] } }]

          on_selection_changed do |_tbl, selection, _added_selection, _removed_selection|
            if selection.is_a?(Array)
              @delete_button.enabled = true
              @update_button.enabled = selection.length == 1
            end
          end
        end

        @manipulators_zone = horizontal_box do
          stretchy false

          horizontal_box do
            @load_button = button('Обзор') do |but|
              but.enabled = false
              on_clicked do
                path = open_file
                @pagination_entry.enabled = true
                @previous_button.enabled = true
                @next_button.enabled = true
                @append_button.enabled = true
                on_create({ json_file: path }) if path
              end
            end

            label('Источник данных') { stretchy false }

            combobox do |combo|
              items ['База данных', 'JSON-файл']
              on_selected do
                reset_table
                case combo.selected
                when 0
                  @pagination_entry.enabled = true
                  @append_button.enabled = true
                  @load_button.enabled = false
                  on_create
                when 1
                  @pagination_entry.enabled = false
                  @previous_button.enabled = false
                  @next_button.enabled = false
                  @append_button.enabled = false
                  @load_button.enabled = true
                end
              end
            end
          end
        end

        vertical_separator { stretchy false }

        @button_box = vertical_box do
          @append_button = button('Добавить') do |but|
            but.enabled = false
            on_clicked do
              @create_student_obj = CreateStudentView.new(@controller).display
            end
          end

          @update_button = button('Изменить') do |but|
            but.enabled = false
            on_clicked do
              @update_student_obj = SelectChangeableView.new(self, @controller).display
            end
          end

          @delete_button = button('Удалить') do |but|
            but.enabled = false
            on_clicked do
              @delete_student_obj = DeleteStudentController.new(self, @controller).delete
            end
          end
          button('Обновить')
        end
      end
    end
  end

  def on_create(data_source = nil)
    @controller.on_student_list_view_created(data_source)
    @controller.refresh_data(@current_page, @quan_rows, @filters)
  end

  def update(data_table_obj)
    rows = data_table_obj.n_rows
    columns = data_table_obj.n_columns
    arr = []
    (0...rows).each do |i|
      temp = []
      (0...columns).each { |j| temp << data_table_obj.get(i, j) }
      arr << temp
    end
    @table_zone.cell_rows = arr
  end

  def update_total_count(actual_count)
    @total_count = actual_count
    @pagination_label.text = "Страница № #{@current_page} из #{quan_pages(@total_count, @quan_rows)}"
  end

  def quan_pages(total_count, quan_rows)
    total_count % quan_rows != 0 ? total_count / quan_rows + 1 : total_count / quan_rows
  end

  def column_state
    @column_full_name_count = 0 if @column_full_name_count == 3
    result = @column_full_name_states[@column_full_name_count]
    @column_full_name_count += 1
    result
  end

  def reset_table
    @current_page = 1
    @quan_rows = 10
    @pagination_entry.text = quan_rows.to_s
    @pagination_label.text = 'Страница № 0 из 0'
    @table_zone.cell_rows = Array.new(5) { [] }
  end

  def reset_all_search
    @table_zone.cell_rows = @table_search_clone
    @full_name_sort_clone = nil
    @full_name_column.sort_indicator = nil
    @table_search_clone = nil
    all_search_obj = instance_variables.select { |var| var.to_s.end_with?('search') }
    all_search_obj.map! { |sym| instance_variable_get(sym) }
    all_search_obj.map! { |glimmer_obj| glimmer_obj.text = '' }
  end

  def search_set_mode(some_search, mode)
    case mode
    when :on
      some_search.enabled = true
    when :off
      some_search.enabled = false
      some_search.text = ''
    end
  end

  def sort_by_name(current_arr, sort_order)
    sorted = current_arr.sort_by { |field| [field[1]] }
    if sort_order == :ascending
      return sorted
    elsif sort_order
      return sorted.reverse
    end

    @full_name_sort_clone
  end
end
