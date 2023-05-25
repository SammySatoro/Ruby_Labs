require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Controllers/LaboratoryWork/create_lw_controller.rb'
require 'glimmer-dsl-libui'

class CreateLWView
  include Glimmer

  DATE = /^(0[1-9]|[12]\d|3[01])\.(0[1-9]|1[0-2])\.(19\d\d|20\d\d|21\d\d|22\d\d|23\d\d)$/

  attr_reader :number_label, :create_window

  def initialize(senior_controller)
    @controller = CreateLWController.new(self, senior_controller)

    @required_fields = {
      name: false,
      date_of_issue: false,
    }
  end

  def display
    @create_window = window('Добавить лабораторную работу', 800, 400) {
      margined true
      grid {

        label('№') {
          top 0
          left 0
          valign :center
          halign :end
        }

        label('Наименование'){
          top 1
          left 0
          valign :center
          halign :end
        }

        label('Темы'){
          top 2
          left 0
          valign :center
          halign :end
        }

        label('Перечень задач'){
          top 3
          left 0
          valign :center
          halign :end
        }

        label('Дата выдачи'){
          top 5
          left 0
          valign :center
          halign :end
        }

        @number_label = label {
          top 0
          left 1
          hexpand true
        }

        @name_entry = entry {
          top 1
          left 1
          on_changed do |en|
            on_enter_values(en, nil, //, :name)
          end
        }

        @themes_entry = multiline_entry {
          top 2
          left 1
          vexpand true
        }

        @list_of_tasks_entry = multiline_entry{
          top 3
          left 1
          vexpand true
        }

        @date_of_issue_label_check = label('') { |lb|
          top 4
          left 1
          lb.enabled = false
        }

        @date_of_issue_entry = entry {
          top 5
          left 1
          on_changed do |en|
            on_enter_values(en, @date_of_issue_label_check, DATE, :date_of_issue)
          end
        }

        @append_button = button('Добавить') { |but|
          but.enabled = false
          top 6
          left 1
          vexpand true
          on_clicked do
            if @controller.current_number > 1
              if @controller.valid_date_of_issue?(@date_of_issue_entry.text.force_encoding("UTF-8"))
                input_scan
              else
                msg_box('Важная информация', 'Дата выдачи добавляемой ЛР должна быть больше, чем дата выдачи последней ЛР!')
              end
            else
              input_scan
            end
          end
        }

        @name_label_check = label { |lb|
          lb.visible = false
        }
      }
    }
    @controller.fill_view
  end

  def label_set_mode(some_label, state)
    if state == :on
      some_label.enabled = true
      some_label.text = 'Неправильный формат введенной строки!'
    elsif state == :off
      some_label.enabled = false
      some_label.text = ''
    end
  end

  def on_enter_values(entry_obj, label_obj=nil, regex, symbol)
    filter_value = entry_obj.text
    filter_value.force_encoding("UTF-8")
    if filter_value != ''
      unless filter_value.match?(regex)
        label_set_mode(label_obj, :on) if label_obj
        @required_fields[symbol] = false if @required_fields.key?(symbol)
        fields_check
      else
        label_set_mode(label_obj, :off) if label_obj
        @required_fields[symbol] = true if @required_fields.key?(symbol)
        fields_check
      end
    else
      label_set_mode(label_obj, :off) if label_obj
      @required_fields[symbol] = false if @required_fields.key?(symbol)
      fields_check
    end
  end

  def fields_check
    if @required_fields.values.all?(true)
      @append_button.enabled = true
    else
      @append_button.enabled = false
    end
  end

  def input_scan
    all_entry_obj = self.instance_variables.select { |var| var.to_s.end_with?('entry') }
    all_entry_obj.map! { |sym| self.instance_variable_get(sym) }
    all_entry_obj.map! { |glimmer_obj| glimmer_obj.text.force_encoding("UTF-8") }
    @controller.append(all_entry_obj)
    @create_window.destroy
  end
end

