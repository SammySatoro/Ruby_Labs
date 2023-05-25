require 'glimmer-dsl-libui'
require_relative 'update_student_view_temp'

class SelectChangeableControllerTest
  include Glimmer

  def initialize(senior_controller=nil)
    @senior_controller = senior_controller
  end

  def create_update_window(window_type)
    fields = {
      last_name: /(^[А-Я][а-я]+$)|(^[A-Z][a-z]+$)/,
      first_name: /(^[А-Я][а-я]+$)|(^[A-Z][a-z]+$)/ ,
      patronymic: /(^[А-Я][а-я]+$)|(^[A-Z][a-z]+$)/,
      git: /^https:\/\/github\.com\/([A-Za-z0-9_.-]+)\/?$/,
      phone: /^\+?[78] ?[(-]?\d{3} ?[)-]?[ -]?\d{3}[ -]?\d{2}[ -]?\d{2}$/,
      telegram: /\A@[\w_.]{2,32}\z/,
      email: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    }

    condition, required_flag = case window_type
    when :full_name_window
      [[:last_name, :first_name, :patronymic], true]
    when :git_window
      [[:git], false]
    when :contacts_window
      [[:phone, :telegram, :email], false]
    else
      raise(ArgumentError, 'Заданный тип окна не найден!')
    end

    entry_hash = fields.select { |key, value| condition.include?(key) }
    label_arr = entry_hash.keys + fields.keys.select { |key| !condition.include?(key) }
    UpdateStudentViewTemp.new(entry_hash, label_arr, required_flag, @senior_controller).display
  end
end
