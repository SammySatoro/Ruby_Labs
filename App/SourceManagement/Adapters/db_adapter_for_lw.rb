require 'sqlite3'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Models/laboratory_work.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Models/laboratory_work_light.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Manipulators/data_list_laboratory_work.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/SourceManagement/DBSystem/db_connection.rb'

class DBAdapterForLW

  attr_reader :count_number

  def initialize
    @database_object = DBConnection.instance
    set_count_number
  end

  def get_by_number(number)
    request = @database_object.get_cursor.execute "select * from LaboratoryWork where number=#{number}"
    request.empty? ? nil : to_lw(*request)
  end

  def append(object)
    temp = object.to_hash
    temp = temp.keys.map { |key| object.send(key) }
    temp.shift
    temp.map! { |el| el == '-' ? 'null' : el}
    values = ""
    temp.each { |el| el == 'null' ? values += "#{el}," : values += "'#{el}',"}
    @database_object.get_cursor.execute "insert into LaboratoryWork (#{self.attr}) values (#{values[0..values.length - 2]})"
    set_count_number
  end

  def replace_by_number(number, object)
    hash = object.to_hash
    hash.delete("regex")
    hash.delete('number')
    hash.transform_values! { |value| value.nil? ? 'null' : value }
    request = ''
    hash.each_pair { |key, value| value == 'null' ? request += "#{key.to_s} = #{value}," : request += "#{key.to_s} = '#{value}',"}
    @database_object.get_cursor.execute "update LaboratoryWork set #{request[0..request.length-2]} where number = #{number}"
  end

  def delete_by_number(number)
    @database_object.get_cursor.execute "delete from LaboratoryWork where number=#{number}"
    set_count_number
  end

  def get_all_lw(exist_data_list=nil)
    hash = @database_object.get_cursor.execute  "select * from LaboratoryWork"
    if exist_data_list
      exist_data_list.arr = to_lw_light_arr(hash)
      return exist_data_list
    end
    to_data_list_lw_light(hash)
  end

  def get_lw_count
    hash = @database_object.get_cursor.execute  "select count(*) from LaboratoryWork"
    hash.first.values.first
  end

  def last_date_of_issue
    hash = @database_object.get_cursor.execute("select max(date_of_issue) from LaboratoryWork").first
    hash['max(date_of_issue)'].nil? ? '01.01.2000' : hash['max(date_of_issue)']
  end

  def set_count_number
    hash = @database_object.get_cursor.execute("select max(number) from LaboratoryWork").first
    @count_number = hash['max(number)'].nil? ? 1 : hash['max(number)'] + 1
  end

  protected

  def to_lw(hash)
    hash.transform_keys! { |key| key.to_sym }
    LaboratoryWork.from_hash(hash)
  end

  def to_lw_light_arr(arr_hash)
    arr_hash.map! { |hash| to_lw(hash) }
    arr_hash.map! { |lw_obj| LaboratoryWorkLight.from_object(lw_obj) }
  end

  def to_data_list_lw_light(arr_hash)
    to_lw_light_arr(arr_hash)
    DataListLaboratoryWork.new(arr_hash)
  end

  def valid_data_list?(object)
    object.is_a?(DataListLaboratoryWork)
  end

  def attr
    "number, name, themes, list_of_tasks, date_of_issue"
  end
end
