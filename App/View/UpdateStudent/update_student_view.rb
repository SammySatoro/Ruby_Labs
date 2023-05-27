require 'glimmer-dsl-libui'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Controllers/update_student_controller.rb'

class UpdateStudentView
  include Glimmer

  attr_writer :string_representation
  attr_reader :view_from_attr, :update_window

  def initialize(main_view, senior_controller, entry_hash, label_arr, required_flag)
    @controller = UpdateStudentController.new(self, main_view, senior_controller)
    @source_entry_hash = entry_hash
    @source_label_arr = label_arr
    @required_flag = required_flag
    @view_from_attr = {}

    self.set_state_fields(required_flag)
    self.string_representation = {
      last_name: 'Фамилия',
      first_name: 'Имя' ,
      patronymic: 'Отчество',
      git: 'Git',
      phone: 'Номер телефона',
      telegram: 'Telegram',
      email: 'Email'
    }
  end

  def display
    @update_window = window('Update', 650, 250) { |wind|
      margined true
      vertical_box {

        horizontal_box {
          vertical_box {
            stretchy false
            horizontal_separator {stretchy false}
            self.set_label_name_field_box
          }

          vertical_separator {stretchy false}

          vertical_box {
            stretchy false
            self.set_entry_box
            self.set_label_value_field_box
          }

          vertical_separator {stretchy false}

          vertical_box {
            stretchy true
            horizontal_separator {stretchy false}
            self.set_label_check_box
          }
        }

        @update_button = button('Изменить') { |but|
          stretchy false
          #@required_flag ? but.enabled = false : but.enabled = true
          on_clicked do
            self.input_scan
            wind.destroy
          end
        }
      }
    }

    @controller.fill_view
    @update_window
  end

  protected

  def set_state_fields(required_val)
    #bool = required_val ? false : true
    @state_fields = @source_entry_hash.keys.map { |key| [key, true] }.to_h
  end

  def set_label_name_field_box
    (@source_entry_hash.keys + @source_label_arr).each do |name|
      temp_str = "@#{name.to_s}_label_name_field"
      glimmer_label = self.create_label(@string_representation[name])
      self.instance_variable_set(temp_str.to_sym, glimmer_label)
    end
  end

  def set_entry_box
    @source_entry_hash.each_pair do |name, regex|
      label_check_name = "@#{name.to_s}_label_check".to_sym
      self.instance_variable_set(label_check_name, nil)
      entry_name = "@#{name.to_s}_entry".to_sym
      glimmer_entry = self.create_entry(label_check_name.to_sym, regex, name)
      self.instance_variable_set(entry_name, glimmer_entry)
      @view_from_attr[name] = self.instance_variable_get(entry_name)
    end
  end

  def set_label_value_field_box
    @source_label_arr.each do |name|
      label_value_field = "@#{name.to_s}_label_value_field"
      glimmer_label = self.create_label
      self.instance_variable_set(label_value_field, glimmer_label)
      @view_from_attr[name] = self.instance_variable_get(label_value_field)
    end
  end

  def set_label_check_box
    label_check_arr = self.instance_variables.select { |attr| attr.to_s.end_with?("label_check") }
    label_check_arr.each { |attr| self.instance_variable_set(attr, create_label_check)}
  end

  def create_label(name='Something')
    result = label(name) {stretchy false}
    horizontal_separator {stretchy false}
    result
  end

  def create_label_check
    result = label { |lb|
      stretchy false
      lb.enabled = false
    }
    horizontal_separator {stretchy false}
    result
  end

  def create_entry(some_label_check, regex, entry_name)
    entry {
      stretchy true
      on_changed do |en|
        on_enter_values(en, self.instance_variable_get(some_label_check), regex, entry_name)
      end
    }
  end

  def input_scan
    input_values = @view_from_attr.filter { |key, value| @source_entry_hash.key?(key) }
    input_values.transform_values! { |entry| entry.text.force_encoding('UTF-8') }
    input_values.transform_values! { |str| str == '' ? nil : str}
    @controller.update(input_values)
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

  def on_enter_values(entry_obj, label_obj, regex, symbol)
    filter_value = entry_obj.text
    filter_value.force_encoding("UTF-8")
    begin
      if filter_value != ''
        unless filter_value.match?(regex)
          label_set_mode(label_obj, :on)
          @state_fields[symbol] = false if @state_fields.key?(symbol)
          fields_check
        else
          label_set_mode(label_obj, :off)
          @state_fields[symbol] = true if @state_fields.key?(symbol)
          fields_check
        end
      else
        label_set_mode(label_obj, :off)
        @required_flag ? @state_fields[symbol] = false : @state_fields[symbol] = true
        fields_check
      end
    rescue => error
      print error
    end
  end

  def fields_check
    if @state_fields.values.all?(true)
      @update_button.enabled = true
    else
      @update_button.enabled = false
    end
  end

end
