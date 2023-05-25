require_relative 'student_super'
require 'json'

class Student < StudentSuper

  public_class_method :new

  public :id, :id=,
         :git, :git=,
         :phone, :phone=,
         :telegram, :telegram=,
         :email, :email=

  NAME = /(^[А-Я][а-я]+$)|(^[A-Z][a-z]+$)/

  def Student.valid_name?(str)
    str.match?(/(^[А-Я][а-я]+$)|(^[A-Z][a-z]+$)/)
  end

  def Student.from_string(id, str)
    class_field = [:id, :last_name, :first_name, :patronymic, :git, :phone, :telegram, :email]

    begin
      value = str.split(', ')
      value.unshift(id)

      if value.size < class_field.size
        raise(ArgumentError,"Неверный формат переданной строки.\nПроверьте кол-во переданных значений.")
      end

      value.map! { |val| val == '-' ? nil : val }
      arg = class_field.zip(value).to_h
      from_hash(arg)
    rescue NoMethodError
      puts 'Переданное значение не подлежит парсингу!'
    end
  end

  def Student.from_hash(dict)
    id = dict.delete(:id)
    last_name = dict.delete(:last_name)
    first_name = dict.delete(:first_name)
    patronymic = dict.delete(:patronymic)
    new(id, last_name, first_name, patronymic, **dict)
  end

  def initialize(id, last_name, first_name, patronymic, git:nil, phone:nil, telegram:nil, email:nil)
    raise(ArgumentError, 'ФИО - обязательные параметры!') unless last_name && first_name && patronymic
    self.id = id
    self.last_name = last_name
    self.first_name = first_name
    self.patronymic = patronymic
    self.git = git
    self.phone = phone
    self.telegram = telegram
    self.email = email
  end

  def to_json
    JSON.pretty_generate(as_hash)
  end

  def last_name=(value)
    raise(ArgumentError, 'Неправильная фамилия!') unless !value.nil? && Student.valid_name?(value)
    @last_name = value
  end

  def first_name=(value)
    raise(ArgumentError, "Неправильное имя! #{value}") unless !value.nil? && Student.valid_name?(value)
    @first_name = value
  end

  def patronymic=(value)
    raise(ArgumentError, 'Неправильное отчество!') unless !value.nil? && Student.valid_name?(value)
    @patronymic = value
  end

  def get_info
    contacts_sym = [:@phone, :@telegram, :@email]
    index = contacts_sym.find_index { |sym| !self.instance_variable_get(sym).nil? }
    contact = index ? [contacts_sym[index].to_s.gsub(/@/,''), self.instance_variable_get(contacts_sym[index])] : %w[contact -]
    "#{@last_name} #{@first_name[0]}. #{@patronymic[0]}., #{@git ? @git : '-'}, #{contact[0]}:#{contact[1]}"
  end

  def as_hash
    field = self.instance_variables.map { |sym| sym.to_s.gsub(/@/,'') }
    value = field.inject([]) { |acc, attr| acc.push self.instance_eval(attr) }
    field.zip(value).to_h
  end

end
