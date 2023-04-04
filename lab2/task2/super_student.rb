# frozen_string_literal: true
require_relative 'student_regexes'

class SuperStudent
  include(StudentRegexes)

  private_class_method :new

  def SuperStudent.valid_id?(value)
    value = value.to_s
    value.match?(ID_REGEX)
  end

  def SuperStudent.valid_git?(value)
    value.match?(GIT_REGEX)
  end

  def SuperStudent.valid_phone_number?(value)
    value.match?(PHONE_REGEX)
  end

  def SuperStudent.valid_telegram?(value)
    value.match?(TELEGRAM_REGEX)
  end

  def SuperStudent.valid_email(value)
    value.match?(EMAIL_REGEX)
  end

  attr_reader :id, :surname, :first_name, :patronymic, :phone_number, :telegram, :email, :git

  def to_s
    self.instance_variables.map do |var|
      "#{var}: #{self.instance_variable_get(var).inspect}"
    end.join(", ")
  end

  protected

  def id=(value)
    value = value.to_s
    raise(ArgumentError, `invalid argument: #{value}`) unless SuperStudent.valid_id?(value)
    @id = value
  end

  def phone_number=(value)
    raise(ArgumentError, `invalid argument: #{value}`) unless value.nil? || value.match?(PHONE_REGEX)
    @phone_number = value
  end

  def email=(value)
    raise(ArgumentError, `invalid argument: #{value}`) unless value.nil? || value.match?(EMAIL_REGEX)
    @email = value
  end

  def git=(value)
    raise(ArgumentError, `invalid argument: #{value}`) unless value.nil? || value.match?(GIT_REGEX)
    @git = value
  end

  def telegram=(value)
    raise(ArgumentError, `invalid argument: #{value}`) unless value.nil? || value.match?(TELEGRAM_REGEX)
    @telegram = value
  end

  def set_contacts(phone:nil, telegram:nil, email:nil)
    self.phone_number = phone if phone
    self.telegram = telegram if telegram
    self.email = email if email
  end


  def valid?
    git_exists? && contact_exists?
  end

  def git_exists?
    @git
  end

  def contact_exists?
    @phone_number || @telegram || @email
  end
end
