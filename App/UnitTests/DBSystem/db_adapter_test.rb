require 'sqlite3'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Models/student.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Models/student_short.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Manipulators/data_list_student_short.rb'
require_relative 'db_connection_test'

class DBAdapterTest

  attr_reader :order_in_arr

  def initialize
    @database_object = DBConnectionTest.instance
    #@position_in_arr = [:last_name, :first_name, :patronymic, :git, :phone, :telegram, :email].zip((0..6).to_a).to_h
    set_count_id
  end

  def get_by_id(id)
    request = @database_object.get_cursor.execute "select * from Студенты where id=#{id}"
    to_student(*request)
  end

  def get_k_n_student_short_list(list_number, quan_element, exist_data_list=nil, filters_hash=nil)
    message = "В качестве необязатального аргумента может использоваться только объект типа DataListStudentShort!"
    request_result = @database_object.get_cursor.execute "select * from Студенты limit #{(list_number - 1) * quan_element}, #{quan_element}"

    request_result = apply_filters(request_result, filters_hash) if filters_hash

    if exist_data_list
      raise(ArgumentError, message) unless valid_data_list?(exist_data_list)
      exist_data_list.arr = to_student_short_arr(request_result)
      return exist_data_list
    end
    to_data_list_student_short(request_result)
  end

  def append(object)
    temp = object.to_s.split(', ').map! { |el| el == '-' ? 'null' : el}
    values = ""
    temp.each { |el| el == 'null' ? values += "#{el}," : values += "'#{el}',"}
    @database_object.get_cursor.execute "insert into Студенты (#{self.attr}) values (#{values[0..values.length - 2]})"
  end

  def replace_by_id(id, object)
    hash = object.as_hash
    hash.delete("id")
    hash.transform_values! { |value| value.nil? ? 'null' : value }
    request = ''
    hash.each_pair { |key, value| value == 'null' ? request += "#{key.to_s} = #{value}," : request += "#{key.to_s} = '#{value}',"}
    @database_object.get_cursor.execute "update Студенты set #{request[0..request.length-2]} where id = #{id}"
  end

  def delete_by_id(id)
    @database_object.get_cursor.execute "delete from Студенты where id=#{id}"
  end

  def get_student_count
    hash = @database_object.get_cursor.execute  "select count(*) from Студенты"
    hash.first.values.first
  end

  def id_count
    res = @id_count
    @id_count += 1
    res
  end

  protected

  def set_count_id
    hash = @database_object.get_cursor.execute("SELECT max(id) FROM Студенты").first
    @id_count = hash['max(id)'] + 1
  end

  def valid_data_list?(object)
    object.is_a?(DataListStudentShort)
  end

  def attr
    "last_name, first_name, patronymic, git, phone, telegram, email"
  end

  def to_student(hash)
    hash.transform_keys! { |key| key.to_sym }
    Student.from_hash(hash)
  end

  def to_student_short_arr(arr_hash)
    arr_hash.map! { |hash| to_student(hash) }
    arr_hash.map! { |stud_obj| StudentShort.from_object(stud_obj) }
  end

  def to_data_list_student_short(arr_hash)
    to_student_short_arr(arr_hash)
    DataListStudentShort.new(arr_hash)
  end

  def apply_filters(arr_hash, filters)
    filters.each_pair do |key, value|
      condition = value ? lambda { |field| !field.nil? } : lambda { |field| field.nil? }
      arr_hash.select! { |hash| condition.call(hash[key.to_s])}
    end
    arr_hash
  end
end

