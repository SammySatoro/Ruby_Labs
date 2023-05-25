require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Controllers/update_student_controller.rb '
require 'glimmer-dsl-libui'

class UpdateStudentView
  include Glimmer

  NAME = /(^[А-Я][а-я]+$)|(^[A-Z][a-z]+$)/

  attr_reader :student_form

  def initialize(main_view, senior_controller)
    @controller = UpdateStudentController.new(self, main_view, senior_controller)

    @required_fields = {
      last_name_view: true,
      first_name_view: true,
      patronymic_view: true
    }
  end

  def display
    @student_form = window('Изменить ФИО студента', 650, 200) { |window|
      margined true
      vertical_box {
        horizontal_box {
          stretchy false

          vertical_box {
            stretchy false
            horizontal_separator {stretchy false}
            label('Фамилия') {stretchy false }
            horizontal_separator {stretchy false}
            label('Имя') {stretchy false }
            horizontal_separator {stretchy false}
            label('Отчество') {stretchy false}
            horizontal_separator {stretchy false}
            label('Git') {stretchy false}
            horizontal_separator {stretchy false}
            label('Номер телефона') {stretchy false}
            horizontal_separator {stretchy false}
            label('Telegram') {stretchy false}
            horizontal_separator {stretchy false}
            label('Email') {stretchy false}
            horizontal_separator {stretchy false}
          }

          vertical_separator {stretchy false}

          vertical_box {
            stretchy true

            @last_name_entry = entry { |en|
              stretchy false
              on_changed do
                on_enter_values(en, @last_name_label_check, NAME, :last_name_view)
              end
            }

            @first_name_entry = entry { |en|
              stretchy false
              on_changed do
                on_enter_values(en, @first_name_label_check, NAME, :first_name_view)
              end
            }

            @patronymic_entry = entry { |en|
              stretchy false
              on_changed do
                on_enter_values(en, @patronymic_label_check, NAME, :patronymic_view)
              end
            }

            @git_label = label('Something')
            @phone_label = label('Something')
            @telegram_label = label('Something')
            @email_label = label('Something')
          }

          vertical_separator {stretchy false}

          vertical_box {
            stretchy true

            vertical_separator {stretchy false}
            @last_name_label_check = label('') { |lb|
              stretchy false
              lb.enabled = false
            }
            horizontal_separator {stretchy false}
            @first_name_label_check = label('') { |lb|
              stretchy false
              lb.enabled = false
            }
            horizontal_separator {stretchy false}
            @patronymic_label_check = label('') { |lb|
              stretchy false
              lb.enabled = false
            }
            horizontal_separator {stretchy false}
          }
        }

        @update_button = button('Изменить') { |but|
          stretchy false
          on_clicked do
            all_entry_obj = self.instance_variables.select { |var| var.to_s.end_with?('entry') }
            all_entry_obj.map! { |sym| self.instance_variable_get(sym) }
            all_entry_obj.map! { |glimmer_obj| glimmer_obj.text.force_encoding("UTF-8") }
            @controller.update(all_entry_obj)
            window.destroy
          end
        }
      }
    }
    @controller.fill_view
  end

  def on_enter_values(entry_obj, label_obj, regex, symbol)
    filter_value = entry_obj.text
    filter_value.force_encoding("UTF-8")
    if filter_value != ''
      unless filter_value.match?(regex)
        label_on_or_off(label_obj, :on)
        @required_fields[symbol] = false if @required_fields.key?(symbol)
        fields_check
      else
        label_on_or_off(label_obj, :off)
        @required_fields[symbol] = true if @required_fields.key?(symbol)
        fields_check
      end
    else
      label_on_or_off(label_obj, :off)
      @required_fields[symbol] = false if @required_fields.key?(symbol)
      fields_check
    end
  end

  def label_on_or_off(some_label, state)
    if state == :on
      some_label.enabled = true
      some_label.text = 'Неправильный формат введенной строки!'
    elsif state == :off
      some_label.enabled = false
      some_label.text = ''
    end
  end

  def fields_check
    @required_fields.values.all?(true) ? @update_button.enabled = true : @update_button.enabled = false
  end

end



