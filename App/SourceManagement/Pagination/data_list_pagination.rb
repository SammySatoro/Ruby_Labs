require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Manipulators/data_list_student_short.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Manipulators/data_table.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Models/student_short.rb'

class DataListPagination

  private_class_method :new

  def self.convert(data_list_obj, list_number, quan_element)
    @@obj = new(data_list_obj, list_number, quan_element)
    @@obj.matrix_with_id
  end

  attr_reader :matrix_with_id

  def initialize(data_list_obj, list_number, quan_element)
    @data_list_obj = data_list_obj
    @data_table_obj = @data_list_obj.data
    @rows = @data_table_obj.n_rows
    @columns = @data_table_obj.n_columns
    @list_number = list_number
    @quan_element = quan_element
    raise(ArgumentError, 'невозможно извлечь n список из k элементов') unless valid_k_n?
    processing
  end

  protected

  def processing
    extract_data_table
    matching_with_id
    to_tuple
    create_objects
  end

  def extract_data_table
    @matrix = []
    (0...@rows).each do |i|
      temp_arr = []
      (0...@columns).each { |j| temp_arr.push @data_table_obj.get(i, j) }
      @matrix.push(temp_arr)
    end
  end

  def matching_with_id
    @matrix.map! do |arr|
      arr.shift
      arr
    end
    (1..@rows).each { |number| @data_list_obj.sel(number) }
    @id_arr = @data_list_obj.get_selected
    @data_list_obj.clear_selected
  end

  def to_tuple
    @matrix.map! { |arr| "#{arr[0]}, #{arr[1]}, #{arr[2]}"}
    @matrix_with_id = @id_arr.zip(@matrix)
  end

  def create_objects
    @matrix_with_id.map! { |id, str| StudentShort.new(id, str)}
    @matrix_with_id = @matrix_with_id[(@list_number - 1) * @quan_element...@list_number * @quan_element]
  end

  def valid_k_n?
    k_lists_of_n_items = @rows / @quan_element
    @list_number > k_lists_of_n_items ? false : true
  end

end
