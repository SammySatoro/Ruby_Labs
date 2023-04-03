# frozen_string_literal: true
require_relative 'student_regexes'
require_relative 'super_student'

class Student < SuperStudent
  include(StudentRegexes)

  public_class_method :new

  public :id, :id=, :git, :git=, :phone_number, :phone_number=, :telegram, :telegram=, :email, :email=

  def self.from_string(id, values)
    fields_list = [:id, :surname, :first_name, :patronymic, :git, :phone, :telegram, :email]

    begin
      values_list = [id] + values.split(FROM_STRING_REGEX)
      raise ArgumentError, `Invalid number of values: #{values_list.size}, should be #{fields_list.size}`unless
        values_list.size == fields_list.size

      args = values_list.zip(fields_list).to_h
      from_hash(args)
    rescue ArgumentError
      puts 'Cannot parse values...'
    end
  end

  def Student.from_hash(args)
    id = args.delete(:id)
    last_name = args.delete(:last_name)
    first_name = args.delete(:first_name)
    patronymic = args.delete(:patronymic)
    new(id, last_name, first_name, patronymic, **args)
  end

  def Student.valid_name_part?(value)
    value.match?(NAME_PART_REGEX)
  end

  def initialize(id, surname, first_name, patronymic, git:nil, phone_number:nil, telegram:nil, email:nil)
    raise(ArgumentError, 'surname, first_name and patronymic are required!') unless
      surname && first_name && patronymic
    self.id = id
    self.surname = surname
    self.first_name = first_name
    self.patronymic = patronymic
    self.git = git
    self.phone_number = phone_number
    self.telegram = telegram
    self.email = email
  end

  def surname=(value)
    raise(ArgumentError, `invalid argument: #{value}`) unless !value.nil? && Student.valid_name_part?(value)
    @surname = value
  end

  def first_name=(value)
    raise(ArgumentError, `invalid argument: #{value}`) unless !value.nil? && Student.valid_name_part?(value)
    @first_name = value
  end

  def patronymic=(value)
    raise(ArgumentError, `invalid argument: #{value}`) unless !value.nil? && Student.valid_name_part?(value)
    @patronymic = value
  end

  def get_info
    contacts = [@phone_number, @telegram, @email]
    "#{@surname} #{@first_name[0]}. #{@patronymic[0]}., #{@git ? @git : '-'}, #{!contacts.empty? ? contacts[0] : '-'}"
  end

end
