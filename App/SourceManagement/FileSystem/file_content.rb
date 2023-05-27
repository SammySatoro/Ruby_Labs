require_relative 'file_loader'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Models/student.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Models/student_short.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Manipulators/data_list_student_short.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/SourceManagement/Pagination/data_list_pagination.rb'

class FileContent

  attr_reader :arr

  def initialize(source_path=nil)
    @file_loader = FileLoader.new
    @path = source_path
    @position_in_arr = [:last_name, :first_name, :patronymic, :git, :phone, :telegram, :email].zip((0..6).to_a).to_h
    set_value if @path
  end

  def read_from_file(source_path)
    set_value(source_path)
  end

  def write_to_file(source_path=nil)
    source_path ? @file_loader.write_to_file(source_path, @arr) : @file_loader.write_to_file(@path, @arr)
  end

  def get_k_n_student_short_list(list_number, quan_element, filters_hash=nil, exist_data_list=nil)
    message = "В качестве необязатального аргумента может использоваться только объект типа DataListStudentShort!"
    stud_short_arr = if list_number * quan_element < @arr.length
                       @arr[(list_number - 1) * quan_element...list_number * quan_element]
                     else
                       (list_number - 1) * quan_element < @arr.length ? @arr[(list_number - 1) * quan_element...@arr.length] : @arr
                     end
    stud_short_arr = apply_filters(stud_short_arr, filters_hash) if filters_hash
    stud_short_arr = stud_short_arr.map { |obj| StudentShort.from_object(obj) }
    if exist_data_list
      raise(ArgumentError, message) unless valid_data_list?(exist_data_list)
      exist_data_list.arr = stud_short_arr
      return exist_data_list
    end
    DataListStudentShort(stud_short_arr)
  end

  def sort_by_full_name
    @arr.sort_by! { |obj| [obj.last_name, obj.first_name, obj.patronymic]}
  end

  def get_by_id(id)
    @arr.find { |obj| obj.id == id }
  end

  def append(object)
    raise(ArgumentError,'Переданное значение должно быть типа Student!') unless valid_student?(object)
    object.id = id_count
    @arr.push(object)
    self.write_to_file
  end

  def replace_by_id(id, object)
    raise(ArgumentError,'Переданное значение должно быть типа Student!') unless valid_student?(object)
    index = @arr.find_index { |obj| obj.id == id }
    object.id = @arr[index].id
    @arr.fill(object, index, 1)
    self.write_to_file
  end

  def delete_by_id(id)
    @arr.reject! { |obj| obj.id == id }
    self.write_to_file
  end

  def get_student_count
    @arr.length
  end

  def id_count
    res = @id_count
    @id_count += 1
    res
  end

  protected

  def set_value(source_path=nil)
    @arr = source_path ? @file_loader.read_from_file(source_path) : @file_loader.read_from_file(@path)
    @id_count = 1
    @arr.each do |obj|
      obj.id = @id_count
      @id_count += 1
    end
  end

  def valid_data_list?(object)
    object.is_a?(DataListStudentShort)
  end

  def valid_student?(object)
    object.is_a?(Student)
  end

  def apply_filters(arr_obj, filters)
    deep_copy_arr_obj = arr_obj.map(&:dup)
    filters.each_pair do |key, value|
      condition = value ? lambda { |field| !field.nil? } : lambda { |field| field.nil? }
      arr_obj.select! { |stud_obj| condition.call(stud_obj.send(key)) }
    end
    arr_obj.empty? ? deep_copy_arr_obj : arr_obj
  end

end

