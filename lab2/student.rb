# frozen_string_literal: true

class Student
  attr_accessor :id, :surname, :first_name, :patronymic, :telegram
  attr_reader :phone_number, :email, :git

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i.freeze

  PHONE_NUMBER_REGEX = /\A\+?\d{11}\z/.freeze

  GIT_REGEX = %r{\Ahttps://github\.com/\w+\z}.freeze

  def initialize(params = { surname: '', first_name: '', patronymic: '' })
    @id = params[:id]
    @surname = params[:surname]
    @first_name = params[:first_name]
    @patronymic = params[:patronymic]

    raise ArgumentError, 'surname, first_name and patronymic are necessary to instantiate the object' unless
      @surname && @first_name && @patronymic
    
    
    @phone_number = (validate_contact_data(params[:phone_number], PHONE_NUMBER_REGEX) if params[:phone_number])
    @email = (validate_contact_data(params[:email], EMAIL_REGEX) if params[:email])
    @git = (validate_contact_data(params[:git], GIT_REGEX) if params[:git])

    @telegram = params[:telegram]
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

  def self.is_valid_phone_number?(phone_number)
    phone_number =~ PHONE_NUMBER_REGEX
  end

end
