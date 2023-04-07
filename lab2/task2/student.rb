# frozen_string_literal: true
require_relative 'super_student'

class Student < SuperStudent
  include(StudentRegexes)

  public_class_method :new

  public :id, :id=, :git, :git=, :phone_number, :phone_number=, :telegram, :telegram=, :email, :email=

  def Student.from_string(id, values)
    fields_list = [:id, :surname, :first_name, :patronymic, :git, :phone_number, :telegram, :email]

    begin
      values_list = [id] + values.split(FROM_STRING_REGEX)
      values_list.map! { |value| value == '-' ? nil : value}
      raise ArgumentError, `Invalid number of values: #{values_list.size}, should be #{fields_list.size}`unless
        values_list.size == fields_list.size

      args = fields_list.zip(values_list).to_h
      from_hash(args)
    rescue ArgumentError
      puts 'Cannot parse values...'
    end
  end
  
  def Student.read_from_txt(path)
    raise ArgumentError, "Invalid path: #{path}" unless File.exist?(path)

    File.readlines(path).map.with_index do |line, index|
      Student.from_string(index, line.chomp)
    end
  end

  def Student.white_to_txt(path, student_list)
    txt_file = File.open(path, 'w')
    student_list.each do |student|
      temp_str = ""
      student.instance_variables.each { |field|
        value = student.instance_variable_get(field)
        temp_str += "#{value == nil ? '-' : value}, "
      }
      txt_file.write("#{temp_str}\n")
    end
    txt_file.close
  end
  
  def Student.from_hash(args)
    id = args.delete(:id)
    surname = args.delete(:surname)
    first_name = args.delete(:first_name)
    patronymic = args.delete(:patronymic)
    new(id, surname, first_name, patronymic, **args)
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
    contacts = [@phone_number, @telegram, @email].compact
    "#{@surname} #{@first_name[0]}. #{@patronymic[0]}., #{@git ? @git : '-'}, #{!contacts.empty? ? contacts[0] : '-'}"
  end

  def to_hash
    {
      id: @id,
      surname: @surname,
      first_name: @first_name,
      patronymic: @patronymic,
      git: @git,
      phone_number: @phone_number,
      telegram: @telegram,
      email: @email
    }
  end

end
