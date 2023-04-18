require_relative 'data_table.rb'
require_relative 'data_list.rb'

class DataListStudentShort < DataList

  def initialize(data_array)
    super
    @names = set_names
  end

  def list=(data_array)
    raise(ArgumentError, 'The array can only contain StudentShort objects!') unless valid_array?(data_array)
    super
    self.data = DataTable.new(@list)
    nil
  end

  protected

  def valid_array?(array)
    array.all? { |obj| obj.is_a?(StudentShort)}
  end

  def set_names
    %w[FullName Git Contact].map.with_index do |attr, index|
      [index, attr]
    end
  end

  def get_names_hop
    @names
  end

  def get_data_hop
    @data
  end

end