
class LaboratoryWorkLight

  attr_accessor :number, :name, :date_of_issue

  def LaboratoryWorkLight.from_object(lw_obj)
    new(lw_obj.number, lw_obj.name, lw_obj.date_of_issue)
  end

    def initialize(number, name, date_of_issue)
    self.number = number
    self.name = name
    self.date_of_issue = date_of_issue
  end

  def to_s
    "#{self.number} #{self.name} #{self.date_of_issue}"
  end
end
