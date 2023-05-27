require_relative 'data_list.rb'
require_relative 'data_table.rb'

class DataListStudentShort < DataList

  attr_reader :subscribers

  def initialize(source_array)
    super
    @names = set_names
  end

  def arr=(source_array)
    raise(ArgumentError, 'Массив может содержать только элементы StudentShort!') unless valid_array?(source_array)
    super
    self.data = DataTable.new(@arr)
    self.notify if @subscribers
  end

  def notify
    @subscribers.each { |obj| obj.update(self.data) }
  end

  protected

  def valid_array?(array)
    array.all? { |obj| obj.is_a?(StudentShort)}
  end

  def set_names
    acc = []
    count_attr = 1
    %w[ФИО Git Контакт].each do |attr|
      acc.push [count_attr, attr]
      count_attr += 1
    end
    acc
  end

end

