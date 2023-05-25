require 'glimmer-dsl-libui'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Controllers/student_list_controller.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Controllers/data_list_contract.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Manipulators/data_table.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Controllers/delete_student_controller.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/View/UpdateStudent/select_changeable_view.rb'
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
    @students_tab = tab_item('Список студентов') {

      vertical_box {

        @pagination_zone = horizontal_box {
          stretchy false

          @previous_button = button('<') {
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
          }

          @next_button = button('>') {
            stretchy false
            on_clicked do
              if @current_page && @quan_rows > 0
                if @total_count % @quan_rows == 0
                  if @current_page < @total_count / @quan_rows
                  @current_page += 1
                  @full_name_column.sort_indicator = nil
                  @full_name_sort_clone = nil
                  @table_search_clone = nil
                  @column_full_name_count = 3
                  @pagination_label.text = "Страница № #{@current_page} из #{quan_pages(@total_count, @quan_rows)}"
                  @controller.refresh_data(@current_page, @quan_rows, @filters)
                  end
                else
                  if @current_page <= @total_count / @quan_rows
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
          }

          label('Количество строк') { stretchy false}

          @pagination_entry = entry { |en|
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
          }

          @pagination_label = label('Страница № 0 из 0')
        }

        @table_zone = table { |table|
          sortable false
          selection_mode :zero_or_many

          text_column('№')

          @full_name_column = text_column('ФИО') {
            on_clicked do |column|
              @full_name_sort_clone ||= table.cell_rows
              state = column_state
              column.sort_indicator = state
              table.cell_rows = sort_by_name(table.cell_rows, state)
            end
          }

          text_column('Git')
          text_column('Контакт')

          cell_rows <= [self, :arr, column_attributes: {'№' => :arr[0],
                                                        'ФИО' => :arr[1],
                                                        'Git' => :arr[2],
                                                        'Контакт' => :arr[3]}]

          on_selection_changed do |tbl, selection, added_selection, removed_selection|
            if selection.is_a?(Array)
              if selection.length == 1
                @delete_button.enabled = true
                @update_button.enabled = true
              else
                @delete_button.enabled = true
                @update_button.enabled = false
              end
            end
          end
        }

        @manipulators_zone = horizontal_box {
          stretchy false

          @labels_box = vertical_box {
            stretchy false
            label('Фамилия и инициалы')
            label('Наличие Git')
            label("Наличие номера телефона")
            label("Наличие Telegram")
            label("Наличие Email")
          }

          vertical_separator { stretchy false }

          @combos_box = vertical_box {
            stretchy false

            combo_items = %w[Да Нет Неважно]

            combobox

            @git_combo = combobox { |combo|
              items combo_items
              selected combo.items[2]

              on_selected do
                reset_all_search
                if combo.selected_item == 'Да'
                  search_set_mode(@git_search, :on)
                  @filters[:git] = true
                  @controller.refresh_data(@current_page, @quan_rows, @filters)
                elsif combo.selected_item == 'Нет'
                  search_set_mode(@git_search, :off)
                  @filters[:git] = false
                  @controller.refresh_data(@current_page, @quan_rows, @filters)
                else
                  @filters.delete(:git)
                  @controller.refresh_data(@current_page, @quan_rows, @filters)
                end
              end
            }

            @phone_combo = combobox { |combo|
              items combo_items
              selected combo.items[2]
            }

            @telegram_combo = combobox { |combo|
              items combo_items
              selected combo.items[2]
            }

            @email_combo = combobox { |combo|
              items combo_items
              selected combo.items[2]
            }
          }

          vertical_separator { stretchy false }

          @search_box = vertical_box {
            horizontal_box {
              stretchy false

              vertical_box {
                stretchy false
                label('UnifiedSearch') {stretchy true }
                horizontal_separator { stretchy false }
                label('GitSearch') {stretchy true }
              }

              vertical_separator {stretchy false }

              vertical_box {
                stretchy true

                @unified_search = search_entry { |search|
                  on_changed do
                    search_set_mode(@git_search, :off)
                    filter_value = search.text
                    filter_value.force_encoding("UTF-8")
                    @table_search_clone ||= @table_zone.cell_rows
                    @table_zone.cell_rows = @table_search_clone.dup
                    if filter_value.empty?
                      @table_search_clone = nil
                      search_set_mode(@git_search, :on)
                    else
                      @table_zone.cell_rows = @table_zone.cell_rows.filter do |row_data|
                        row_data.any? do |cell|
                          cell.to_s.downcase.include?(filter_value.downcase)
                        end
                      end
                    end
                  end
                }

                horizontal_separator {stretchy false}

                @git_search = search_entry { |search|
                  search.enabled = false
                  on_changed do
                    search_set_mode(@unified_search, :off)
                    filter_value = search.text
                    filter_value.force_encoding("UTF-8")
                    @table_search_clone ||= @table_zone.cell_rows
                    @table_zone.cell_rows = @table_search_clone.dup
                    if filter_value.empty?
                      @table_search_clone = nil
                      search_set_mode(@unified_search, :on)
                    else
                      @table_zone.cell_rows = @table_zone.cell_rows.filter do |row_data|
                        row_data[2].to_s.downcase.include?(filter_value.downcase)
                      end
                    end
                  end
                }

              }
            }

            button('Отменить выбор') {
              on_clicked do
                @table_zone.selection = []
                @update_button.enabled = false
                @delete_button.enabled = false
              end
            }

            button('Сбросить фильтры') {
              on_clicked do
                item = 'Неважно'
                @git_combo.selected item
                @phone_combo.selected item
                @telegram_combo.selected item
                @email_combo.selected item
                @filters = {}
                @controller.refresh_data(@current_page, @quan_rows, @filters)
              end
            }

            horizontal_box {
              @load_button = button('Обзор') {
                |but| but.enabled = false
                on_clicked do
                  path = open_file
                  @pagination_entry.enabled = true
                  @previous_button.enabled = true
                  @next_button.enabled = true
                  @append_button.enabled = true
                  on_create({json_file: path}) if path
                end
              }

              label('Источник данных')  { stretchy false }

              combobox { |combo|
                items ['База данных', 'JSON-файл']
                on_selected do
                  reset_table
                  if combo.selected == 0
                    @pagination_entry.enabled = true
                    @append_button.enabled = true
                    @load_button.enabled = false
                    on_create
                  elsif combo.selected == 1
                    @pagination_entry.enabled = false
                    @previous_button.enabled = false
                    @next_button.enabled = false
                    @append_button.enabled = false
                    @load_button.enabled = true
                  end
                end
              }
            }
          }

          vertical_separator { stretchy false }

          @button_box = vertical_box {
            @append_button = button('Добавить') { |but|
              but.enabled = false
              on_clicked do
                @create_student_obj = CreateStudentView.new(@controller).display
              end
            }

            @update_button = button('Изменить') { |but|
              but.enabled = false
              on_clicked do
                @update_student_obj = SelectChangeableView.new(self, @controller).display
              end
            }

            @delete_button = button('Удалить') { |but|
              but.enabled = false
              on_clicked do
                @delete_student_obj = DeleteStudentController.new(self, @controller).delete
              end
            }
            button('Обновить')
          }
        }
      }
    }
  end

  def on_create(data_source=nil)
    @controller.on_student_list_view_created(data_source)
    @controller.refresh_data(@current_page, @quan_rows, @filters)
  end

  def update(data_table_obj)
    rows = data_table_obj.n_rows
    columns = data_table_obj.n_columns
    arr = []
    (0...rows).each do |i|
      temp = []
      (0...columns).each { |j| temp << data_table_obj.get(i,j) }
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
    @pagination_entry.text = "#{quan_rows}"
    @pagination_label.text = "Страница № 0 из 0"
    @table_zone.cell_rows = Array.new(5) { [] }
  end

  def reset_all_search
    @table_zone.cell_rows = @table_search_clone
    @full_name_sort_clone = nil
    @full_name_column.sort_indicator = nil
    @table_search_clone = nil
    all_search_obj = self.instance_variables.select { |var| var.to_s.end_with?('search') }
    all_search_obj.map! { |sym| self.instance_variable_get(sym) }
    all_search_obj.map! { |glimmer_obj| glimmer_obj.text = '' }
  end

  def search_set_mode(some_search, mode)
    if mode == :on
      some_search.enabled = true
    elsif mode == :off
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

