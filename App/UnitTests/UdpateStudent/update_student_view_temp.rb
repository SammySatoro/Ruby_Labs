require 'glimmer-dsl-libui'

class UpdateStudentViewTempTest
  include Glimmer

  attr_writer :string_representation

  def initialize(entry_hash, label_arr, required_flag, senior_controller=nil)
    @source_entry_hash = entry_hash
    @source_label_arr = label_arr
    @senior_controller = senior_controller
    @required_flag = required_flag

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
    window('Update',650, 250) {
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
          @required_flag ? but.enabled = false : but.enabled = true
        }
      }
    }.show
  end

  def set_state_fields(required_val)
    bool = required_val ? false : true
    @state_fields = @source_entry_hash.keys.map { |key| [key, bool] }.to_h
  end

  def set_label_name_field_box
    @source_label_arr.each do |name|
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
    end
  end

  def set_label_value_field_box
    label_value_field_arr = @source_label_arr.select { |field| !@source_entry_hash.keys.include?(field) }
    label_value_field_arr.each do |name|
      label_value_field = "@#{name.to_s}_label_value_field"
      glimmer_label = self.create_label
      self.instance_variable_set(label_value_field, glimmer_label)
    end
  end

  def set_label_check_box
    label_check_arr = self.instance_variables.select { |attr| attr.to_s.end_with?("label_check") }
    label_check_arr.each { |attr| self.instance_variable_set(attr, create_label_check)}
  end

  def create_label(name='Something')
    label(name) {stretchy false}
    horizontal_separator {stretchy false}
  end

  def create_label_check
    res = label('something') { |lb|
      stretchy false
      lb.enabled = false
    }
    horizontal_separator {stretchy false}
    res
  end

  def create_entry(some_label_check, regex, entry_name)
    entry {
      stretchy true
      on_changed do |en|
        on_enter_values(en, self.instance_variable_get(some_label_check), regex, entry_name)
      end
    }
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
