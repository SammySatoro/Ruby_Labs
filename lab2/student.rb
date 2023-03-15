# frozen_string_literal: true

class Student
  attr_accessor :id, :surname, :first_name, :patronymic, :telegram
  attr_reader :phone_number, :email, :git

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i.freeze

  PHONE_NUMBER_REGEX = /\+?\d{11}\z/.freeze

  GIT_REGEX = %r{\Ahttps://github\.com/\w+\z}.freeze

  def initialize(params = {})
    @id = params[:id]
    @surname = params[:surname]
    @first_name = params[:first_name]
    @patronymic = params[:patronymic]

    raise ArgumentError, 'surname, first_name and patronymic are necessary to instantiate the object' unless
      @surname && @first_name && @patronymic

    set_contacts(params[:phone_number], params[:email], params[:telegram], params[:git])

  end

  def self.from_string(string)
    id, surname, first_name, patronymic, phone_number, telegram, email, git = string.split(',')
    params = {
      id: id,
      surname: surname,
      first_name: first_name,
      patronymic: patronymic,
      phone_number: phone_number,
      telegram: telegram,
      email: email,
      git: git
    }
    new(params)
  end

  def phone_number=(value)
    @phone_number = (validate_contact_data(value, PHONE_NUMBER_REGEX) if value)
  end

  def email=(value)
    @email = (validate_contact_data(value, EMAIL_REGEX) if value)
  end

  def git=(value)
    @git = (validate_contact_data(value, GIT_REGEX) if value)
  end

  def to_s
    "ID: #{@id}, Surname: #{@surname}, Name: #{@first_name}, Patronymic: #{@patronymic}, Phone number: #{@phone_number}, Telegram: #{@telegram}, Email: #{@email}, Git: #{@git}"
  end

  def validate_contact_data(contact, regex)
    raise ArgumentError, 'Invalid contact format' unless contact =~ regex || contact == ''

    contact
  end

  def is_phone_number_valid?(phone_number)
    phone_number =~ PHONE_NUMBER_REGEX
  end

  def git_exists?
    (puts "git: #{@git}") || (return true) if @git

    false
  end

  def contact_data_exists?
    if @phone_number || @email || @telegram
      (@phone_number && (puts "phone number: #{@phone_number}")) ||
        (@email && (puts "email: #{@email}")) ||
        (@telegram && (puts "telegram: #{@telegram}")) ||
        (return true)
    end

    false
  end

  def validate
    git_exists? && contact_data_exists?
  end

  def set_contacts(phone_number, email, telegram, git)
    @phone_number = (validate_contact_data(phone_number, PHONE_NUMBER_REGEX) if phone_number)
    @email = (validate_contact_data(email, EMAIL_REGEX) if email)
    @git = (validate_contact_data(git, GIT_REGEX) if git)
    @telegram = telegram if telegram
  end

end


