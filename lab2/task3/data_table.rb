require_relative '../task2/student.rb'

class DataTable

  def initialize(data_array)
    @table = []

    data_array.each do |data|
      tmp = []
      data[1].instance_variables.each { |field|
        value = data[1].instance_variable_get("#{field}")
        tmp << value
      }
      @table << tmp
    end
  end

  def item(i, j)
    @table[i][j]
  end

  def rows_size
    @table.size
  end

  def columns_size
    @table[0].size
  end

end
