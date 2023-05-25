require 'glimmer-dsl-libui'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Controllers/create_student_controller.rb'


class CreateStudentView
  include Glimmer

  NAME = /(^[А-Я][а-я]+$)|(^[A-Z][a-z]+$)/
  GIT = /\Ahttps:\/\/github\.com\/\w+\z/
  PHONE = /^\+?[78] ?[(-]?\d{3} ?[)-]?[ -]?\d{3}[ -]?\d{2}[ -]?\d{2}$/
  TELEGRAM = /^[a-zA-Z0-9_.]+$/
  EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  def initialize(main_controller)
    @controller = CreateStudentController.new(main_controller)

    @required_fields = {
      last_name_view: false,
      first_name_view: false,
      patronymic_view: false
    }

    @optional_fields = {
      git_view: true,
      phone_view: true,
      telegram_view: true,
      email_view: true
    }
  end

  def display
    @student_form = window('Добавить студента', 800, 200) { |window|
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
                on_enter_values(en, @last_name_label, NAME, :last_name_view)
              end
            }

            @first_name_entry = entry { |en|
              stretchy false
              on_changed do
                on_enter_values(en, @first_name_label, NAME, :first_name_view)
              end
            }

            @patronymic_entry = entry { |en|
              stretchy false
              on_changed do
                on_enter_values(en, @patronymic_label, NAME, :patronymic_view)
              end
            }

            @git_entry = entry { |en|
              stretchy false
              on_changed do
                on_enter_values(en, @git_label, GIT, :git_view)
              end
            }

            @phone_entry = entry { |en|
              stretchy false
              on_changed do
                on_enter_values(en, @phone_label, PHONE, :phone_view)
              end
            }

            @telegram_entry = entry { |en|
              stretchy false
              on_changed do
                on_enter_values(en, @telegram_label, TELEGRAM, :telegram_view)
              end
            }

            @email_entry = entry { |en|
              stretchy false
              on_changed do
                on_enter_values(en, @email_label, EMAIL, :email_view)
              end
            }
          }

          vertical_separator {stretchy false}

          vertical_box {
            stretchy true

            vertical_separator {stretchy false}
            @last_name_label = label('') { |lb|
              stretchy false
              lb.enabled = false
            }
            horizontal_separator {stretchy false}
            @first_name_label = label('') { |lb|
              stretchy false
              lb.enabled = false
            }
            horizontal_separator {stretchy false}
            @patronymic_label = label('') { |lb|
              stretchy false
              lb.enabled = false
            }
            horizontal_separator {stretchy false}
            @git_label = label('') { |lb|
              stretchy false
              lb.enabled = false
            }
            horizontal_separator {stretchy false}
            @phone_label = label('') { |lb|
              stretchy false
              lb.enabled = false
            }
            horizontal_separator {stretchy false}
            @telegram_label = label('') { |lb|
              stretchy false
              lb.enabled = false
            }
            horizontal_separator {stretchy false}
            @email_label = label('') { |lb|
              stretchy false
              lb.enabled = false
            }
            vertical_separator {stretchy false}
          }
        }

        @append_button = button('Добавить студента') { |but|
          stretchy false
          but.enabled = false
          on_clicked do
            all_entry_obj = self.instance_variables.select { |var| var.to_s.end_with?('entry') }
            all_entry_obj.map! { |sym| self.instance_variable_get(sym) }
            all_entry_obj.map! { |glimmer_obj| glimmer_obj.text.force_encoding("UTF-8") }
            all_entry_obj.map! { |text| text == '' ? nil : text }
            @controller.append(all_entry_obj)
            window.destroy
          end
        }
      }
    }.show
  end

  protected

  def on_enter_values(entry_obj, label_obj, regex, symbol)
    filter_value = entry_obj.text
    filter_value.force_encoding("UTF-8")
    if filter_value != ''
      unless filter_value.match?(regex)
        label_set_mode(label_obj, :on)
        @required_fields[symbol] = false if @required_fields.key?(symbol)
        @optional_fields[symbol] = false if @optional_fields.key?(symbol)
        fields_check
      else
        label_set_mode(label_obj, :off)
        @required_fields[symbol] = true if @required_fields.key?(symbol)
        @optional_fields[symbol] = true if @optional_fields.key?(symbol)
        fields_check
      end
    else
      label_set_mode(label_obj, :off)
      @required_fields[symbol] = false if @required_fields.key?(symbol)
      @optional_fields[symbol] = true if @optional_fields.key?(symbol)
      fields_check
    end
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

  def fields_check
    if @required_fields.values.all?(true) && @optional_fields.values.all?(true)
      @append_button.enabled = true
    else
      @append_button.enabled = false
    end
  end
end
