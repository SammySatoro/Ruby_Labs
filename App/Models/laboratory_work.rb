require_relative 'laboratory_work_light'

class LaboratoryWork

  attr_accessor :name, :themes, :list_of_tasks
  attr_reader :number, :date_of_issue, :regex

  def LaboratoryWork.from_hash(hash)
    number = hash.delete(:number)
    name = hash.delete(:name)
    date_of_issue = hash.delete(:date_of_issue)
    new(number, name, date_of_issue, **hash)
  end

  def initialize(number, name,  date_of_issue, themes:nil, list_of_tasks:nil)
    msg = 'ЛР должна обязательно должна содеражать номер, наименование и дату выдачи!'
    raise(ArgumentError, msg) unless number && name && date_of_issue
    @regex = { date_of_issue: /^(0[1-9]|[12]\d|3[01])\.(0[1-9]|1[0-2])\.(19\d\d|20\d\d|21\d\d|22\d\d|23\d\d)$/ }
    self.number = number
    self.name = name
    self.themes = themes
    self.list_of_tasks = list_of_tasks
    self.date_of_issue = date_of_issue
  end

  def number=(value)
    raise(ArgumentError, 'Неккоректный номер ЛР!') unless value.nil? || value.is_a?(Integer) && value >= 1
    @number = value
  end

  def date_of_issue=(value)
    raise(ArgumentError, 'Неккоректный формат даты выдачи!') unless regex[:date_of_issue].match?(value)
    @date_of_issue = value
  end

  def regex=(hash)
    @regex.merge!(hash)
  end

  def to_s
    "#{self.number.to_s}\n#{self.name}\n#{self.themes.nil? ? '-' : self.themes}\n#{self.list_of_tasks.nil? ? '-' : self.list_of_tasks}\n#{self.date_of_issue}"
  end

  def get_light_version
    LaboratoryWorkLight.from_object(self)
  end

  def to_hash
    field = self.instance_variables.map { |sym| sym.to_s.gsub(/@/,'') }
    value = field.inject([]) { |acc, attr| acc.push self.instance_eval(attr) }
    field.zip(value).to_h
  end
end
