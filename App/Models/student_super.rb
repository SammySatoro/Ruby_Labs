
class StudentSuper

  private_class_method :new

  GIT = /^https:\/\/github\.com\/([A-Za-z0-9_.-]+)\/?$/
  PHONE = /^\+?[78] ?[(-]?\d{3} ?[)-]?[ -]?\d{3}[ -]?\d{2}[ -]?\d{2}$/
  TELEGRAM = /\A@[\w_.]{2,32}\z/
  EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  def StudentSuper.valid_git?(str)
    str.match?(GIT)
  end

  def StudentSuper.valid_phone?(str)
    str.match?(PHONE)
  end

  def StudentSuper.valid_telegram?(str)
    str.match?(TELEGRAM)
  end

  def StudentSuper.valid_email?(str)
    str.match?(EMAIL)
  end

  attr_reader :id, :last_name,
              :first_name, :patronymic,
              :phone, :telegram,
              :email, :git

  def to_s
    str_represent = ""
    field = self.instance_variables
    field.map! { |sym| sym.to_s.gsub(/@/,'') }
    field.select! { |el| el != 'id' }
    field.each do |attr|
      temp = self.instance_eval(attr)
      str_represent += "#{temp ? temp : '-'}, "
    end
    str_represent[0..str_represent.length-3]
  end

  protected

  def id=(value)
    raise(ArgumentError, 'Полю ID должно быть присвоено целочисленное значение') unless value.is_a?(Integer)
    @id = value
  end

  def git=(value)
    raise(ArgumentError, "Неверный формат Git!#{self.id} #{value.class}") unless value.nil? || StudentSuper.valid_git?(value)
    @git = value
  end

  def phone=(value)
    raise(ArgumentError, 'Неверный формат номера телефона!') unless value.nil? || StudentSuper.valid_phone?(value)
    @phone = value
  end

  def telegram=(value)
    raise(ArgumentError, "Неверный формат ника telegram!#{self.id}") unless value.nil? || StudentSuper.valid_telegram?(value)
    @telegram = value
  end

  def email=(value)
    raise(ArgumentError, 'Неверный формат email') unless value.nil? || StudentSuper.valid_email?(value)
    @email = value
  end

  def set_contacts(phone:nil, telegram:nil, email:nil)
    self.phone = phone if phone
    self.telegram = telegram if telegram
    self.email = email if email
  end

  def available?
    has_git? && has_contacts?
  end

  def has_git?
    @git ? true : false
  end

  def has_contacts?
    @phone || @telegram || @email ? true : false
  end

end
